unit untRcxCuponsConfirmacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, DB,  
  Uni, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade;

type
  TfrmRcxCuponsConfirmacao = class(TfrmPai)
    dbgDocumentos: TDBGridCitel;
    qryDocumentos: TUniQuery;
    dtsDocumentos: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strNumCoo: String;
    strNumDoc: String;
  end;

var
  frmRcxCuponsConfirmacao: TfrmRcxCuponsConfirmacao;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmRcxCuponsConfirmacao.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
  Begin
    strNumDoc := qryDocumentos.FieldByName('FIS_NUMDOC').AsString;
    ModalResult := mrOk;
  End
  Else If Key = VK_ESCAPE Then
  Begin
    Close;
  End
  Else
    inherited;
end;

procedure TfrmRcxCuponsConfirmacao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgDocumentos);
end;

procedure TfrmRcxCuponsConfirmacao.FormShow(Sender: TObject);
begin
  inherited;
  strNumDoc := '';

  qryDocumentos.Close;
  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add('SELECT ');
  qryDocumentos.SQL.Add('  FIS_NUMDOC, ');
  qryDocumentos.SQL.Add('  FIS_DTAENT, ');
  qryDocumentos.SQL.Add('  CONCAT(FIS_FORCLI, "-", CLI_NOMCLI) AS FIS_NOMCLI, ');
  qryDocumentos.SQL.Add('  IFNULL(FIS_VLCON1,0)+ ');
  qryDocumentos.SQL.Add('  IFNULL(FIS_VLCON2,0)+ ');
  qryDocumentos.SQL.Add('  IFNULL(FIS_VLCON3,0)+ ');
  qryDocumentos.SQL.Add('  IFNULL(FIS_VLCON4,0)+ ');
  qryDocumentos.SQL.Add('  IFNULL(FIS_VLCON5,0) AS FIS_VLRTOT, ');
  qryDocumentos.SQL.Add('  CONCAT(GER_CODVEN, "-", OPE_NOMOPE) AS FIS_NOMVEN ');
  qryDocumentos.SQL.Add('FROM ');
  qryDocumentos.SQL.Add('  CADFIS ');
  qryDocumentos.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ');
  qryDocumentos.SQL.Add('  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ');
  qryDocumentos.SQL.Add('                 GER_ESPDOC = FIS_ESPDOC AND ');
  qryDocumentos.SQL.Add('                 GER_CODEMP = FIS_CODEMP AND ');
  qryDocumentos.SQL.Add('                 GER_CODCLI = FIS_FORCLI AND ');
  qryDocumentos.SQL.Add('                 IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ');
  qryDocumentos.SQL.Add('  JOIN CADOPE ON GER_CODVEN = OPE_CODOPE ');
  qryDocumentos.SQL.Add('WHERE ');
  qryDocumentos.SQL.Add('  GER_JAFATU = 0 AND ');
  qryDocumentos.SQL.Add('  FIS_NUMCOO = :NUMCOO AND ');
  qryDocumentos.SQL.Add('  FIS_CODEMP = :CODEMP ');

  qryDocumentos.ParamByName('NUMCOO').AsString := strNumCoo;
  qryDocumentos.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDocumentos.Open;

  TFloatField(qryDocumentos.FieldByName('FIS_VLRTOT')).DisplayFormat := '#,##0.00';

  blnFecharFormPai := qryDocumentos.IsEmpty;
  If blnFecharFormPai Then
  Begin
    pMensagemOk('Não foram encontrados cupons com este COO nesta empresa.');
  End;
end;

end.
