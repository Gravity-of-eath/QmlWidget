#ifndef QMLARRAYLIST_H
#define QMLARRAYLIST_H

#include <QAbstractListModel>
#include <QVariant>
#include <QList>
#include <qdebug.h>

class QmlArrayList : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit QmlArrayList(QObject *parent = nullptr);

    // Basic functionality:
   Q_INVOKABLE int rowCount(const QModelIndex &parent = QModelIndex()) const override;

   Q_INVOKABLE QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
   Q_INVOKABLE bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

   Q_INVOKABLE void add( const QVariant &value)  ;
   Q_INVOKABLE void remove( const QModelIndex &index)  ;
    Q_INVOKABLE QVariant get( int index)  ;
private:

     QList<QVariant> m_data;
};

Q_DECLARE_METATYPE(QmlArrayList*)
#endif // QMLARRAYLIST_H
