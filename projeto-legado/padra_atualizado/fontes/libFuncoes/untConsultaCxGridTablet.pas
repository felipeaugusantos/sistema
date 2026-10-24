unit untConsultaCxGridTablet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaCxGrid, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, ExtCtrls, UniClientDataSet, 
    Uni, UniDataSetProvider, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess,
  UniProvider, MySQLUniProvider, Datasnap.Provider;

type
  TfrmConsultaCxGridTablet = class(TfrmConsultaCxGrid)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCxGridTablet: TfrmConsultaCxGridTablet;

implementation

{$R *.dfm}

end.
