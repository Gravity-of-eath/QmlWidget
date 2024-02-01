#include "qmlarraylist.h"

QmlArrayList::QmlArrayList(QObject *parent)
    : QAbstractListModel(parent)
{
}


int QmlArrayList::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    qDebug()<<"rowCount :"<<m_data.length();
    return m_data.length();

}

QVariant QmlArrayList::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    qDebug()<<"data index :"<<index.row();
    return m_data.at(index.row());
}

bool QmlArrayList::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        m_data.replace(index.row(),value);
        emit dataChanged(index, index, {role});
        return true;
    }
    return false;
}

void QmlArrayList::add( const QVariant &value)
{
    qDebug()<<"add   :"<<value.toString();
    m_data.append(value);
}

void QmlArrayList::remove( const QModelIndex &index)
{
    m_data.removeAt(index.row());
}

QVariant QmlArrayList::get( int index)
{

    qDebug()<<"get   :"<<index ;
    return m_data.at(index);
}

