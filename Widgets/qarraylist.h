#ifndef QARRAYLIST_H
#define QARRAYLIST_H

#include <QObject>
#include <QVariant>
#include <QList>

class QArrayList : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    QArrayList(QObject *parent = nullptr);

    Q_INVOKABLE void add(const QVariant &value);
    Q_INVOKABLE QVariant get(int index) const;
    Q_INVOKABLE int size() const;
    Q_INVOKABLE void remove(int index)  ;
    Q_INVOKABLE void pop() ;
    ~QArrayList();
signals:
    void countChanged();

private:
    QList<QVariant> m_list;
};

Q_DECLARE_METATYPE(QArrayList*)

#endif // QARRAYLIST_H
