import math
import sys

import numpy as np
import copy
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors


class HelperFunctions():
    def EuclidDistance(self, x, y):
        return np.sqrt(np.sum((x - y) ** 2))

    def clusterSum(self, clusters):
        nElemVector = len(clusters[0][0])
        clusterSums = np.array([np.array([[0.0 for _ in range(nElemVector)]]) for _ in range(len(clusters))])
        clusterCount = 0
        for cluster in clusters:
            for vector in cluster:
                clusterSums[clusterCount] = clusterSums[clusterCount] + np.array(vector)
            clusterCount += 1
        return clusterSums

    def clusterMean(self, clusters):
        # returned mean should be [ [[mu1]],[[mu2]]...[[muk]] ] ->this is going to work with
        # clusterVariance function
        means = self.clusterSum(clusters)
        vectorCount = 0
        clusterCount = 0
        for cluster in clusters:
            for vector in cluster:
                vectorCount += 1.0
            means[clusterCount] = means[clusterCount] / vectorCount
            clusterCount += 1
            vectorCount = 0
        return means

    def clusterVariance(self, clusters, means):
        nClusters = len(clusters)
        nElemVector = len(clusters[0][0])
        initVector = [0 for _ in range(nElemVector)]
        clusterVariances = np.array([0.0 for _ in range(nClusters)])
        """
        for i in range(nClusters):
            clusterInit=[]
            for jVector in clusters[i]:
                clusterInit.append(initVector)
            clusterVariances.append(clusterInit)
        clusterVariances=np.array(clusterVariances,dtype=object)
        """
        for i in range(nClusters):
            # print(clusters[i])
            aux = sum(((np.array(clusters[i]) - np.array(means[i])) ** 2).flatten())
            nVectors = len(clusters[i]) * 1.0
            clusterVariances[i] = (aux / nVectors)
        return clusterVariances


class ClusteringAlgorithm():
    functions = HelperFunctions()

    def __int__(self, model):
        self.model = model

    def __init__(self):
        self.model = None

    def plusPlusInitialization(self, data, nClusters):
        nData, vectorDim = data.shape
        centroids = np.array([data[0]])
        for i in range(1, nClusters):

            all_dist = []
            for point in data:
                d = sys.maxsize
                for center in centroids:
                    dist = functions.EuclidDistance(center, point)
                    d = min(d, dist)
                all_dist.append(d)
            all_dist = np.array(all_dist)
            nextCentroid = data[np.argmax(all_dist), :]
            centroids = np.r_[centroids, [nextCentroid]]
            all_dist = []

        # print(centroids)
        return centroids

    def costFunction(self, clusters, centroids, nClusters):
        mean = np.empty(nClusters, dtype=object)
        for i in range(nClusters):
            mean[i] = [centroids[i].tolist()]
        return sum(functions.clusterVariance(clusters, mean))

    def distanceBetweenCenters(self, centroid1, centroid2, nClusters):
        meanDistance = 0.0  # compute the mean distance between each centroid actualization
        if (len(centroid1.shape) == 3):
            for k in range(nClusters):
                meanDistance += functions.EuclidDistance(centroid1[k][0], centroid2[k][0])
        else:
            for k in range(nClusters):
                meanDistance += functions.EuclidDistance(centroid1[k], centroid2[k])
        # print(meanDistance/nClusters)
        return meanDistance / nClusters

    def kMeans(self, data, nClusters):
        initCentroids = self.plusPlusInitialization(data, nClusters)
        clusters = np.empty(nClusters, dtype=object)
        for i in range(nClusters):
            clusters[i] = [initCentroids[i].tolist()]
        for d in data:
            cost = -1
            clusterIndex = -1
            for i in range(nClusters):
                copyCluster = copy.deepcopy(clusters)
                # print(copyCluster)
                copyCluster[i] = np.r_[copyCluster[i], [d]]
                # print(copyCluster)
                computedCost = self.costFunction(copyCluster, initCentroids, nClusters)
                if (cost == -1 and clusterIndex == -1) or cost > computedCost:
                    cost = computedCost
                    clusterIndex = i
                    # print(f'cluster {i} cost {cost}')
            # print(f'winner----cluster {clusterIndex} cost {cost}')
            clusters[clusterIndex] = np.r_[clusters[clusterIndex], [d]]
            initCentroids = functions.clusterMean(clusters)

        # print(clusters)
        self.model = initCentroids
        return initCentroids, clusters

    def kMeansTol(self, data, nClusters, tolerance=0.001, maxIter=300):
        initCentroids = self.plusPlusInitialization(data, nClusters)
        clusters = np.empty(nClusters, dtype=object)
        for i in range(nClusters):
            clusters[i] = [initCentroids[i].tolist()]
        # print(clusters)
        clusterReinit = copy.deepcopy(clusters)

        iter = 0
        centroids = copy.deepcopy(initCentroids)
        # print(centroids)
        while (self.distanceBetweenCenters(centroids, initCentroids,
                                           nClusters) >= tolerance and iter <= maxIter) or iter == 0:
            clusters = copy.deepcopy(clusterReinit)
            centroids = copy.deepcopy(initCentroids)
            iter += 1

            for d in data:
                cost = -1
                clusterIndex = -1
                for i in range(nClusters):
                    copyCluster = copy.deepcopy(clusters)
                    # print(clusters)
                    copyCluster[i] = np.r_[copyCluster[i], [d]]
                    # print(copyCluster)
                    computedCost = self.costFunction(copyCluster, initCentroids, nClusters)
                    if (cost == -1 and clusterIndex == -1) or cost > computedCost:
                        cost = computedCost
                        clusterIndex = i
                        # print(f'cluster {i} cost {cost}')
                # print(f'winner----cluster {clusterIndex} cost {cost}')
                clusters[clusterIndex] = np.r_[clusters[clusterIndex], [d]]
                initCentroids = functions.clusterMean(clusters)
            # print(self.distanceBetweenCenters(centroids, initCentroids, nClusters))
            # print(iter)
        # print(clusters)
        self.model = initCentroids
        return initCentroids, clusters

    def plotClusters(self, clusters):
        # plotColors = mcolors.TABLEAU_COLORS
        # print(plotColors)
        nClusters = len(clusters)
        for k in range(nClusters):
            nVectors = len(clusters[k])
            for i in range(nVectors):
                plt.plot(clusters[k][i][0], clusters[k][i][1], color='C' + str(k), marker="^")
        plt.show()

    def predict(self, model, points):
        # model consists of the kMeans computed centroids
        nClusters = len(model)
        prediction = {}

        for k in range(nClusters):
            prediction["Cluster " + str(k)] = []

        for point in points:
            minDistance = sys.maxsize
            clusterIndex = -1
            for i in range(nClusters):
                dist = functions.EuclidDistance(model[i][0], point)
                if dist < minDistance:
                    minDistance = dist
                    clusterIndex = i
            prediction["Cluster " + str(clusterIndex)].append(point)

        return prediction

    def predict(self, points):
        # model consists of the kMeans computed centroids
        model = self.model
        nClusters = len(model)
        prediction = {}

        for k in range(nClusters):
            prediction["Cluster " + str(k)] = []

        for point in points:
            minDistance = sys.maxsize
            clusterIndex = -1
            for i in range(nClusters):
                dist = functions.EuclidDistance(model[i][0], point)
                if dist < minDistance:
                    minDistance = dist
                    clusterIndex = i
            prediction["Cluster " + str(clusterIndex)].append(point)

        return prediction


if __name__ == "__main__":
    c = np.array([[[1, 1], [2, 2], [4, 4]], [[4, 4], [4, 4], [5, 4], [4, 4], [4, 4], [4, 4]]],
                 dtype=object)
    functions = HelperFunctions()
    # print(functions.clusterMean(c))
    # print(functions.clusterVariance(c,functions.clusterMean(c)))

    # c = np.array([[1, 1], [2, 3], [4, 2], [5, 5]])

    clustAlg = ClusteringAlgorithm()
    # print(clustAlg.costFunction(c))
    # clustAlg.plusPlusInitialization(np.array([[1, 3], [2, 5], [3, 5], [10, 10],[100, 200],[-5,-10]]), 3)

    # generate a synthetic dataset
    variances = [3, 3, 3,1]
    means = [-4, 3, 10,0.3]
    nClusters = 3
    samples = 50
    data = []
    for k in range(nClusters):
        for i in range(samples):
            xyPair = (2 * np.random.rand(2) - 1) * variances[k] + means[k]
            data.append(xyPair.tolist())
    # data = [[3, 5], [101, 201], [3, 20], [-5, 15], [1, 3], [10, 10], [-8, -4],
    # [-5, -10], [2, 5], [16, 21],[-4,6],[]]
    model, clusters = clustAlg.kMeansTol(np.array(data), nClusters, tolerance=0.0001)
    # model, clusters = clustAlg.kMeans(np.array(data), nClusters)

    clustAlg.plotClusters(clusters)
    print(model)
    # print(clusters)

    points = [[3, 1], [4, 6], [-1, -8]]
    prediction = clustAlg.predict(points)
    print(prediction)
    # print(len(c[1][0]))
    # print(functions.clusterSum(c))
    # print(functions.clusterMean(c))
    # print((c[0][0][0]+c[0][0][1])/3)
