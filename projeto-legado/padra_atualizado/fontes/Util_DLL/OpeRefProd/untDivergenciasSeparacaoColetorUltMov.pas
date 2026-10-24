unit untDivergenciasSeparacaoColetorUltMov;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdenaCxGrid, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxContainer, cxLabel,
  cxDBLabel, cxTextEdit;

type
  TfrmDivergenciasSeparacaoColetorUltMov = class(TfrmPaiOrdenaCxGrid)
    dbgConsultaDadosESPDOC: TcxGridDBColumn;
    dbgConsultaDadosDTHITE: TcxGridDBColumn;
    dbgConsultaDadosQTDITE: TcxGridDBColumn;
    dbgConsultaDadosNOMOPE: TcxGridDBColumn;
    dbgConsultaDadosNUMDOC: TcxGridDBColumn;
    lblCodIte: TcxDBLabel;
    lblNomIte: TcxDBLabel;
    procedure FormShow(Sender: TObject);
    procedure dbgConsultaDadosDblClick(Sender: TObject);
  private
    procedure pBuscaUltimasMovimentacoes(ACodIte, ALocFis: String);
    function fSQLUltimasMovimentacoes(ACodIte, ALocFis: String): String;
    { Private declarations }
  public
    { Public declarations }
    strCodIte: String;
    strLocFis: String;
    class procedure pExibeUltimasMovimentacoes(ACodIte, ALocFis: String);
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmDivergenciasSeparacaoColetorUltMov.dbgConsultaDadosDblClick(
  Sender: TObject);
begin
  Exit;

end;

procedure TfrmDivergenciasSeparacaoColetorUltMov.FormShow(Sender: TObject);
begin
  inherited;
  pBuscaUltimasMovimentacoes(strCodIte, strLocFis);
end;

function TfrmDivergenciasSeparacaoColetorUltMov.fSQLUltimasMovimentacoes(
          ACodIte: String; ALocFis: String): String;
begin
  Result := '';
  Result := Result + ' SELECT  DET_CODITE AS CODITE, ';
  Result := Result + '    DET_ESPDOC AS ESPDOC, ';
  Result := Result + '   	GER_DTAENT AS DTAENT, ';
  Result := Result + '   	GER_HORENT AS HORENT, ';
  Result := Result + '   	DET_QTDITE AS QTDITE, ';
  Result := Result + '   	GER_NUMDOC AS NUMDOC, ';
  Result := Result + '   	OPE_CODOPE AS CODOPE, ';
  Result := Result + '   	OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '   	ITE_DESITE AS DESITE, ';
  Result := Result + '   	LOT_LOCFIS AS LOCFIS, ';
  Result := Result + '   	TIMESTAMP(GER_DTAENT, GER_HORENT) AS DTHENT ';
  Result := Result + ' FROM MOVGER G ';
  Result := Result + ' INNER JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + ' INNER JOIN CADITE I ON D.DET_CODITE = I.ITE_CODITE ';
  Result := Result + ' LEFT JOIN CADLOT L ON D.DET_NUMLOT = L.LOT_NUMLOT ';
  Result := Result + '        AND D.DET_CODITE = L.LOT_CODITE ';
  Result := Result + '        AND D.DET_CODEMP = L.LOT_CODEMP ';
  Result := Result + ' LEFT JOIN CADOPE O ON G.GER_CODVEN = O.OPE_CODOPE ';
  Result := Result + ' WHERE D.DET_CODITE = ' + QuotedStr(ACodIte) + ' ';
  Result := Result + ' AND   L.LOT_LOCFIS = ' + QuotedStr(ALocFis) + ' ';
  Result := Result + ' AND   D.DET_FILKAR = 0 ';
  Result := Result + ' ORDER BY GER_DTAENT DESC, GER_HORENT DESC ';
  Result := Result + ' LIMIT 5 ';
end;

procedure TfrmDivergenciasSeparacaoColetorUltMov.pBuscaUltimasMovimentacoes(ACodIte: String; ALocFis: String);
begin
  cdsConsulta.Close;
  qryConsulta.Close;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add(fSQLUltimasMovimentacoes(ACodIte, ALocFis));
  Try
    cdsConsulta.Open;

    If (cdsConsulta.IsEmpty) Then
    Begin
      pMensagemOk('Sem dados para exibir!');
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmDivergenciasSeparacaoColetorUltMov.pBuscaUltimasMovimentacoes]');
    End;
  End;
end;

class procedure TfrmDivergenciasSeparacaoColetorUltMov.pExibeUltimasMovimentacoes(
  ACodIte, ALocFis: String);
Var
  frmDivergenciasSeparacaoColetorUltMov: TfrmDivergenciasSeparacaoColetorUltMov;
begin
  pCriarFormularios(TfrmDivergenciasSeparacaoColetorUltMov, frmDivergenciasSeparacaoColetorUltMov);
  Try
    frmDivergenciasSeparacaoColetorUltMov.strCodIte := ACodIte;
    frmDivergenciasSeparacaoColetorUltMov.strLocFis := ALocFis;
    frmDivergenciasSeparacaoColetorUltMov.ShowModal;
  Finally;
    FreeAndNil(frmDivergenciasSeparacaoColetorUltMov);
  End;
end;

end.
