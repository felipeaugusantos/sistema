unit untResumoQuantidadeVendasPerdidas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Vcl.StdCtrls,
  cxGridCustomView, cxClasses, cxGridLevel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncoesSimples;

type
  TfrmResumoQuantidadeVendasPerdidas = class(TfrmPaiEdit)
    cxgVendas: TcxGrid;
    cxgVendasLevel1: TcxGridLevel;
    cxgVendasDB: TcxGridDBTableView;
    pnlLegendas: TPanel;
    Label5: TLabel;
    lblProduto: TLabel;
    Label1: TLabel;
    lblUnidade: TLabel;
    cxgGiroEMPCOD: TcxGridDBColumn;
    cxgGiroNOMEMP: TcxGridDBColumn;
    cxgGiroDTACAD: TcxGridDBColumn;
    cxgGiroCODIGO: TcxGridDBColumn;
    cxgGiroCODCLI: TcxGridDBColumn;
    cxgGiroNOMCLI: TcxGridDBColumn;
    cxgGiroDESMOT: TcxGridDBColumn;
    cxgGiroCODITE: TcxGridDBColumn;
    cxgGiroQTDITE: TcxGridDBColumn;
    dtsVendas: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    cdsVenda: TZClient;
    FstrCodSim: String;
    FstrDesIte: String;
    FstrUniIte: String;
    FstrCodEmp: String;
    FstrCodIte: String;
    FstrMeses: String;
    function fSQLResumo: String;
    { Private declarations }
  public
    { Public declarations }

    function fShowModal: TfrmResumoQuantidadeVendasPerdidas;
    function fCodIte(strCodIte: String): TfrmResumoQuantidadeVendasPerdidas;
    function fCodSim(strCodSim: String): TfrmResumoQuantidadeVendasPerdidas;
    function fDesIte(strDesIte: String): TfrmResumoQuantidadeVendasPerdidas;
    function fUniIte(strUniIte: String): TfrmResumoQuantidadeVendasPerdidas;
    function fCodEmp(strCodEmp: String): TfrmResumoQuantidadeVendasPerdidas;
    function fMeses(strMeses: String): TfrmResumoQuantidadeVendasPerdidas;
    class function fNovo: TfrmResumoQuantidadeVendasPerdidas;
  end;

var
  frmResumoQuantidadeVendasPerdidas: TfrmResumoQuantidadeVendasPerdidas;

implementation

{$R *.dfm}

function TfrmResumoQuantidadeVendasPerdidas.fCodEmp(
  strCodEmp: String): TfrmResumoQuantidadeVendasPerdidas;
begin
  Result := Self;
  FstrCodEmp := strCodEmp;
end;

function TfrmResumoQuantidadeVendasPerdidas.fCodIte(
  strCodIte: String): TfrmResumoQuantidadeVendasPerdidas;
begin
  Result := Self;
  FstrCodIte := strCodIte;
end;

function TfrmResumoQuantidadeVendasPerdidas.fCodSim(
  strCodSim: String): TfrmResumoQuantidadeVendasPerdidas;
begin
  Result := Self;
  FstrCodSim := strCodSim;
end;

function TfrmResumoQuantidadeVendasPerdidas.fMeses(
  strMeses: String): TfrmResumoQuantidadeVendasPerdidas;
begin
  Result := Self;
  FstrMeses := strMeses;
end;

function TfrmResumoQuantidadeVendasPerdidas.fDesIte(
  strDesIte: String): TfrmResumoQuantidadeVendasPerdidas;
begin
  Result := Self;
  FstrDesIte := strDesIte;
end;

Function TfrmResumoQuantidadeVendasPerdidas.fSQLResumo: String;
Begin
  Result := EmptyStr;
  Result := Result + 'SELECT ';
  Result := Result + '  EMP_CODEMP CODEMP,';
  Result := Result + '  EMP_NOMEMP NOMEMP,';
  Result := Result + '  VPG_DTACAD DTACAD,';
  Result := Result + '  VPD_CODIGO CODIGO,';
  Result := Result + '  VPG_CODCLI CODCLI,';
  Result := Result + '  CLI_NOMCLI NOMCLI,';
  Result := Result + '  MOT_DESMOT DESMOT,';
  Result := Result + '  VPD_CODITE CODITE,';
  Result := Result + '  VPD_QTDITE QTDITE';
  Result := Result + '  FROM               ';
  Result := Result + '    MOVVPD';
  Result := Result + '    INNER JOIN MOVVPG ON VPG_CODEMP = VPD_CODEMP AND VPG_CODIGO = VPD_CODIGO';
  Result := Result + '    INNER JOIN MOTVPD ON MOT_CODMOT = VPD_CODMOT AND MOT_CONPED = "S"';
  Result := Result + '    INNER JOIN ITEGER I ON I.ITE_CODITE = VPD_CODITE AND I.ITE_CODEMP = VPD_CODEMP';
  Result := Result + '    INNER JOIN CADCLI ON CLI_CODCLI = VPG_CODCLI';
  Result := Result + '    INNER JOIN CADITE CS ON CS.ITE_CODITE = VPD_CODITE';
  Result := Result + '    INNER JOIN CADEMP ON EMP_CODEMP = VPD_CODEMP';
  Result := Result + '  WHERE';
  Result := Result + '    VPD_CODEMP IN (' + FstrCodEmp + ')';
  Result := Result + '  AND ((I.ITE_CPRCEN = "N") OR (IFNULL(I.ITE_EMPCEN, fCfgSis(''CFG_EMPMAT'',"' + VS_strCodEmp +'")) = I.ITE_CODEMP))';
  If fEmptyStr(FstrCodSim)  Then
    Result := Result + '   AND VPD_CODITE = ' + FstrCodIte.QuotedString
  else
    Result := Result + '   AND CS.ITE_CODSIM  = ' + FstrCodSim.QuotedString;
  Result := Result + '   AND DATE_FORMAT(VPG_DTACAD,"%Y/%m") IN (' + FstrMeses + ')';
End;

function TfrmResumoQuantidadeVendasPerdidas.fUniIte(
  strUniIte: String): TfrmResumoQuantidadeVendasPerdidas;
begin
  Result := Self;
  FstrUniIte := strUniIte;
end;

class function TfrmResumoQuantidadeVendasPerdidas.fNovo: TfrmResumoQuantidadeVendasPerdidas;
begin
  Result := TfrmResumoQuantidadeVendasPerdidas.Create(nil);
end;

function TfrmResumoQuantidadeVendasPerdidas.fShowModal: TfrmResumoQuantidadeVendasPerdidas;
begin
  Result := Self;
  Result.ShowModal;
end;

procedure TfrmResumoQuantidadeVendasPerdidas.FormShow(Sender: TObject);
begin
  inherited;
  lblProduto.Caption := FstrCodIte +
    ' - ' +
    FstrDesIte;
  lblUnidade.Caption := FstrUniIte;

  Self.cdsVenda := TZClient.Create(Self, fSQLResumo);
  Try
    Self.cdsVenda.fAbreClient(True, '[TfrmResumoQuantidadeVendasPerdidas.FormShow]');
    dtsVendas.DataSet := Self.cdsVenda;
    cxgVendasDB.ViewData.Expand(true);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[FormShow]');
  End;
end;

end.
