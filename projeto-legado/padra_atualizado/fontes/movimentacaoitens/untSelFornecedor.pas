unit untSelFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Data.DB, MemDS, DBAccess, Uni,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmSelFornecedor = class(TfrmPai)
    pnlHeader: TPanel;
    dbgConsulta: TDBGridCitel;
    btnOK: TBitBtnLocked;
    qryConsulta: TUniQuery;
    dtsConsulta: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FFornecedorSelecionado: String;
  public
    { Public declarations }
    property strFornecedorSelecionado :String read FFornecedorSelecionado  write FFornecedorSelecionado;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelFornecedor: TfrmSelFornecedor;

implementation

{$R *.dfm}

procedure TfrmSelFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  qryConsulta.Close;
  qryConsulta.sql.Clear;
  qryConsulta.SQL.Add(' SELECT FOR_CODFOR, '+
                 '        FOR_NOMFOR, '+
                 '        FOR_C_G_C_, '+
                 '        FOR_CODCID, '+
                 '        CID_NOMCID, '+
                 '        CID_ESTADO  '+
                 ' FROM CADFOR        '+
                 '   LEFT JOIN CADCID ON (CID_CODCID = FOR_CODCID) '+
                 ' WHERE LOCATE(FOR_CODFOR, "'+FFornecedorSelecionado+'") > 0 ');
   qryConsulta.Open;
end;

end.
