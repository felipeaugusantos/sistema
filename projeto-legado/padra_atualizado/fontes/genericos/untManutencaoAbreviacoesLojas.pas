unit untManutencaoAbreviacoesLojas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untZClient, Uni, untFuncoesSimples, DBEditFocus, untTEditFocusExtend,
  untLogAltCadIte;

type
  TTipoCodigo = (tcCODICM, tcCODPIS, tcCODCOF, tcCODIPI);

  TfrmManutencaoAbreviacoesLojas = class(TfrmPaiEdit)
    pnlGrid: TPanel;
    dtsControle: TDataSource;
    cxAbreviacaoes: TcxGrid;
    cxTblAbrev: TcxGridDBTableView;
    cxAbreviacaoesLvl: TcxGridLevel;
    cxABF_POREMP: TcxGridDBColumn;
    cxPCI_POREMP: TcxGridDBColumn;
    cxEMPRESA: TcxGridDBColumn;
    cxCODICM: TcxGridDBColumn;
    cxDESICM: TcxGridDBColumn;
    cxCODPIS: TcxGridDBColumn;
    cxDESPIS: TcxGridDBColumn;
    cxCODCOF: TcxGridDBColumn;
    cxDESCOF: TcxGridDBColumn;
    cxCODIPI: TcxGridDBColumn;
    cxDESIPI: TcxGridDBColumn;
    pnlLegenda: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Shape2: TShape;
    btnReplicaDados: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure cxTblAbrevCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cxTblAbrevEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure btnReplicaDadosClick(Sender: TObject);
    procedure cxTblAbrevKeyPress(Sender: TObject; var Key: Char);

  private
    FCodIte: String;
    qryErros: TZClient;

    qryConAbf: TUniQuery;

    FCodExc: String;
    FCodNcm: String;

    FCampoAbvIcms: TDBEditFocus;
    FCampoAbvPis: TDBEditFocus;
    FCampoAbvCofins: TDBEditFocus;
    FCampoAbvIpi: TDBEditFocus;

    FCampoDesAbvIcms: TEditFocus;
    FCampoDesAbvPis: TEditFocus;
    FCampoDesAbvCofins: TEditFocus;
    FCampoDesAbvIpi: TEditFocus;
    function fSelecionarEmpresas(strCodCfg: String): String;
    { Private declarations }
  protected
    procedure OnScroll(DataSet: TDataSet);
    procedure OnAfterPost(DataSet: TDataSet);
    procedure OnBeforePost(DataSet: TDataSet);
    function fRetDesc(strCod: string; TipoCodigo: TTipoCodigo): string;
    procedure pCarregaQryErro;
    function fTrataVazio(strValue: string): string;
    function fVerificaSeReplicaParaTodos(TipoCodigo: TTipoCodigo): Boolean;

  public

    qryDados: TZClient;

    constructor Create(ACampoAbvIcms: TDBEditFocus;
                       ACampoDesAbvIcms: TEditFocus;
                       ACampoAbvPis: TDBEditFocus;
                       ACampoDesAbvPis: TEditFocus;
                       ACampoAbvCofins: TDBEditFocus;
                       ACampoDesAbvCofins: TEditFocus;
                       ACampoAbvIpi: TDBEditFocus;
                       ACampoDesAbvIPI: TEditFocus
                       ); reintroduce;

    procedure pCarrega(strCodIte: String; blnHeranca: Boolean = False; strAbfPis: string = ''; strAbfCof: string = '');
    procedure pSetPainel(APanel: TPanel);
    procedure pIguala(strCod: string; TipoCodigo: TTipoCodigo);
    function fGrava(strCodIte: string): Boolean;
    function fValidaRegistros: Boolean;
    procedure pExibeMensagem;
    procedure pHabilitaEdicao(blnHabilita: Boolean);

    property strCodNcm: String read FCodNcm write FCodNcm;
    property strCodExc: String read FCodExc write FCodExc;
    procedure pAtualizaAbreviacoesIMendes(ACodAbf: String;ADesAbf: String; ACodEmp: String; blnReplicaTipAbf_1: Boolean);

    { Public declarations }
  end;

implementation

uses
  untTypesSistema, untConsultas,
  untManutencaoAbreviacoesLojasLog, untSelEmpresas;

{$R *.dfm}

{ TfrmPaiEdit1 }
procedure TfrmManutencaoAbreviacoesLojas.btnReplicaDadosClick(Sender: TObject);
var strPorEmpresa,
    strField,
    strValue: String;
    intPosicao: integer;

begin
  inherited;
  If Not pnlLegenda.Enabled then
     Exit;
  If fMensagem('','Replicar as informações para as outras empresas?', ['&Sim', '&Não'], 1) = 1 Then
  Begin
    strPorEmpresa := 'PCI_POREMP';
    If cxCODICM.Focused Then
    begin
      strField := 'CODABF';
      strPorEmpresa := 'ABF_POREMP';
    End
    Else If cxCODPIS.Focused Then
      strField := 'ABFPIS'
    Else If cxCODCOF.Focused Then
      strField := 'ABFCOF'
    Else If cxCODIPI.Focused Then
      strField := 'ABFIPI';
    If strField = '' Then
      Exit;

    strValue := qryDados.FieldByName(strField).AsString;
    intPosicao := qryDados.RecNo;
    qryDados.DisableControls;

    qryDados.First;

    While Not qryDados.Eof Do
    Begin
      If qryDados.FieldByName(strPorEmpresa).AsInteger = 1 Then
      Begin
        qryDados.Edit;
        qryDados.FieldByName(strField).Value := strValue;
        qryDados.Post;
      End;
      qryDados.Next;
    End;
    qryDados.RecNo := intPosicao;

    qryDados.EnableControls;

  End;
end;

constructor TfrmManutencaoAbreviacoesLojas.Create(ACampoAbvIcms: TDBEditFocus;
  ACampoDesAbvIcms: TEditFocus; ACampoAbvPis: TDBEditFocus;
  ACampoDesAbvPis: TEditFocus; ACampoAbvCofins: TDBEditFocus;
  ACampoDesAbvCofins: TEditFocus; ACampoAbvIpi: TDBEditFocus;
  ACampoDesAbvIPI: TEditFocus);
begin
  inherited  Create(nil);
  FCampoAbvIcms := ACampoAbvIcms;
  FCampoDesAbvIcms := ACampoDesAbvIcms;
  FCampoAbvPis := ACampoAbvPis;
  FCampoDesAbvPis := ACampoDesAbvPis;
  FCampoAbvCofins := ACampoAbvCofins;
  FCampoDesAbvCofins := ACampoDesAbvCofins;
  FCampoAbvIpi := ACampoAbvIpi;
  FCampoDesAbvIPI := ACampoDesAbvIPI;
end;

procedure TfrmManutencaoAbreviacoesLojas.cxTblAbrevCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (AViewInfo.Item.Index = cxCODPIS.Index) Or
     (AViewInfo.Item.Index = cxDESPIS.Index) Or
     (AViewInfo.Item.Index = cxCODCOF.Index) Or
     (AViewInfo.Item.Index = cxDESCOF.Index) Or
     (AViewInfo.Item.Index = cxCODIPI.Index) Or
     (AViewInfo.Item.Index = cxDESIPI.Index) Then
  Begin
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxPCI_POREMP.Index]) <> '1') Then
    Begin
       ACanvas.Brush.Color := clSilver;
    End
    Else
    Begin
      ACanvas.Brush.Color := clMoneyGreen ;
    End
  End;

  If (AViewInfo.Item.Index = cxCODICM.Index) Or (AViewInfo.Item.Index = cxDESICM.Index) Then
  Begin
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxABF_POREMP.Index]) <> '1') Then
    Begin
      ACanvas.Brush.Color := clSilver;
    End
    Else
    Begin
      ACanvas.Brush.Color := clMoneyGreen;
    End;
  End;
  ACanvas.Font.Color := clBlack;

  If AViewInfo.Focused Then
  Begin
    ACanvas.Brush.Color := clBlue;
    ACanvas.Font.Color  := clWhite;
  End;


end;

procedure TfrmManutencaoAbreviacoesLojas.cxTblAbrevEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin


  If Not (qryDados.State = dsEdit) Then
    qryDados.Edit;

  If fEntraCons(Key) Then
  Begin

    If (qryDados.FieldbyName('ABF_POREMP').AsString = '1') Then
    Begin
      If AItem.Index = cxCODICM.Index Then
      Begin
        If fPesqAbrevFiscal(Self, nil, nil, qryConAbf, Key, arrSel, True, strCodNcm, strCodExc) Then
        Begin
          qryDados.FieldByName('CODABF').AsString := qryConAbf.FieldByName('ABF_CODABF').AsString;
          qryDados.Post;
        End;
      End;
    End;

    If (qryDados.FieldByName('PCI_POREMP').AsString = '1') Then
    Begin
      If Aitem.Index = cxCODPIS.Index Then
      Begin
        If fPesqPisSai(Self, Nil, Nil, qryConAbf, Key, arrSel, True, 'Consultas de Abreviação de Pis', strCodNcm, strCodExc) Then
        Begin
          qryDados.FieldByName('ABFPIS').AsString := qryConAbf.FieldByName('APC_CODAPC').AsString;
          qryDados.Post;
        End;
      End
      Else If Aitem.Index = cxCODIPI.Index  Then
      Begin
        If fPesqIPISai(Self, Nil, qryConAbf, Key, arrSel, True, 'Consultas de Abreviação de IPI', strCodNcm, strCodExc) Then
        Begin
          qryDados.FieldByName('ABFIPI').AsString := qryConAbf.FieldByName('APC_CODAPC').AsString;
          qryDados.Post;
        End;
      End
      Else If AItem.Index = cxCODCOF.Index  Then
      Begin
        If fPesqCofSai(Self, Nil, Nil, qryConAbf, Key, arrSel, True, 'Consultas de Abreviação de Cofins', strCodNcm, strCodExc) Then
        Begin
          qryDados.FieldByName('ABFCOF').AsString := qryConAbf.FieldByName('APC_CODAPC').AsString;
          qryDados.Post;
        End;
      end;
    End;

    Key := #0;
  End;
end;

procedure TfrmManutencaoAbreviacoesLojas.cxTblAbrevKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If (Not (qryDados.State = dsEdit)) And
     ((cxCODICM.Focused) Or (cxCODPIS.Focused) Or
     (cxCODIPI.Focused) Or (cxCODCOF.Focused)) Then
    qryDados.Edit;
  If fEntraCons(Key) Then
  Begin
    If (qryDados.FieldbyName('ABF_POREMP').AsString = '1') Then
    Begin
      If cxCODICM.Focused Then
      Begin
        If fPesqAbrevFiscal(Self, nil, nil, qryConAbf, Key, arrSel, True, strCodNcm, strCodExc) Then
        Begin
          qryDados.FieldByName('CODABF').AsString := qryConAbf.FieldByName('ABF_CODABF').AsString;
          qryDados.Post;
        End;
      End;
    End;

    If (qryDados.FieldByName('PCI_POREMP').AsString = '1') Then
    Begin
      If cxCODPIS.Focused Then
      Begin
        If fPesqPisSai(Self, Nil, Nil, qryConAbf, Key, arrSel, True, 'Consultas de Abreviação de Pis', strCodNcm, strCodExc) Then
        Begin
          qryDados.FieldByName('ABFPIS').AsString := qryConAbf.FieldByName('APC_CODAPC').AsString;
          qryDados.Post;
        End;
      End
      Else If cxCODIPI.Focused Then
      Begin
        If fPesqIPISai(Self, Nil, qryConAbf, Key, arrSel, True, 'Consultas de Abreviação de IPI', strCodNcm, strCodExc) Then
        Begin
          qryDados.FieldByName('ABFIPI').AsString := qryConAbf.FieldByName('APC_CODAPC').AsString;
          qryDados.Post;
        End;
      End
      Else If cxCODCOF.Focused Then
      Begin
        If fPesqCofSai(Self, Nil, Nil, qryConAbf, Key, arrSel, True, 'Consultas de Abreviação de Cofins', strCodNcm, strCodExc) Then
        Begin
          qryDados.FieldByName('ABFCOF').AsString := qryConAbf.FieldByName('APC_CODAPC').AsString;
          qryDados.Post;
        End;
      end;
    End;

    Key := #0;
  End;

end;

function TfrmManutencaoAbreviacoesLojas.fGrava(strCodIte: string): Boolean;
var strSQL,
    strNomeCampo,
    strValorAntigo,
    strValorAtual: String;
    blnLOGCPR: Boolean;
begin
  If Not fValidaRegistros Then
    Exit(False);

  blnLOGCPR := fCfgSis('LOGCPR', VarBoolean);

  qryDados.AfterScroll := Nil;

  Try
    FCodIte := strCodIte;
    qryDados.Filtered := False;
    qryDados.Filter := '(ALTERADO = 1) AND ((PCI_POREMP = 1) OR (ABF_POREMP = 1))';
    qryDados.Filtered := True;
    qryDados.First;
    strSQL := '';
    While not qryDados.Eof Do
    Begin
      strSQL := strSQL + 'UPDATE ITEGER SET ';
      If qryDados.FieldByName('PCI_POREMP').AsInteger = 1 Then
      Begin
        strSQL := strSQL + '       ITE_ABFIPI = ' + fTrataVazio(qryDados.FieldByName('ABFIPI').AsString) + ',';
        If blnLOGCPR And (fTrataVazio(qryDados.FieldByName('ABFIPI').AsString)<> 'NULL') And (qryDados.FieldByName('ABFIPI').Value <> qryDados.FieldByName('ABFIPI').OldValue) Then
        Begin
          strNomeCampo := 'Abreviação IPI';
          strValorAntigo := VarToStr(qryDados.FieldByName('ABFIPI').OldValue);
          strValorAtual := VarToStr(qryDados.FieldByName('ABFIPI').Value);
          TLogAltCadIte.pGravaLogAlteracaoIndividual(FCodIte, strNomeCampo, strValorAntigo, strValorAtual);
        End;

        strSQL := strSQL + '       ITE_ABFPIS = ' + fTrataVazio(qryDados.FieldByName('ABFPIS').AsString) + ',';
        If blnLOGCPR And (fTrataVazio(qryDados.FieldByName('ABFPIS').AsString)<> 'NULL') And (qryDados.FieldByName('ABFPIS').Value <> qryDados.FieldByName('ABFPIS').OldValue) Then
        Begin
          strNomeCampo := 'Abreviação PIS';
          strValorAntigo := VarToStr(qryDados.FieldByName('ABFPIS').OldValue);
          strValorAtual := VarToStr(qryDados.FieldByName('ABFPIS').Value);
          TLogAltCadIte.pGravaLogAlteracaoIndividual(FCodIte, strNomeCampo, strValorAntigo, strValorAtual);
        End;

        strSQL := strSQL + '       ITE_ABFCOF = ' + fTrataVazio(qryDados.FieldByName('ABFCOF').AsString);
        If blnLOGCPR And (fTrataVazio(qryDados.FieldByName('ABFCOF').AsString)<> 'NULL') And (qryDados.FieldByName('ABFCOF').Value <> qryDados.FieldByName('ABFCOF').OldValue) Then
        Begin
          strNomeCampo := 'Abreviação COFINS';
          strValorAntigo := VarToStr(qryDados.FieldByName('ABFCOF').OldValue);
          strValorAtual := VarToStr(qryDados.FieldByName('ABFCOF').Value);
          TLogAltCadIte.pGravaLogAlteracaoIndividual(FCodIte, strNomeCampo, strValorAntigo, strValorAtual);
        End;

        If qryDados.FieldByName('ABF_POREMP').AsInteger = 1 Then
          strSQL := strSQL + ','
      End;
      If qryDados.FieldByName('ABF_POREMP').AsInteger = 1 Then
      Begin
        strSQL := strSQL + '       ITE_CODABF = ' + fTrataVazio(qryDados.FieldByName('CODABF').AsString);
        If blnLOGCPR And (fTrataVazio(qryDados.FieldByName('CODABF').AsString)<> 'NULL') And (qryDados.FieldByName('CODABF').Value <> qryDados.FieldByName('CODABF').OldValue) Then
        Begin
          strNomeCampo := 'Abreviação ICMS';
          strValorAntigo := VarToStr(qryDados.FieldByName('CODABF').OldValue);
          strValorAtual := VarToStr(qryDados.FieldByName('CODABF').Value);
          TLogAltCadIte.pGravaLogAlteracaoIndividual(FCodIte, strNomeCampo, strValorAntigo, strValorAtual);
        End;
      End;
      strSQL := strSQL + ' WHERE ITE_CODEMP = ' + QuotedStr(qryDados.FieldByName('EMP_CODEMP').AsString);
      strSQL := strSQL + '   AND ITE_CODITE = ' + QuotedStr(FCodIte) + ';';
      qryDados.Next;
    End;

    If fCfgSis('TIPABF') = 2 Then
    Begin
      qryDados.Filtered := False;
      qryDados.Filter := '(ALTERADO = 1) AND (ABF_POREMP = 0)';
      qryDados.Filtered := True;
      If Not qryDados.IsEmpty Then
      Begin
        strSQL := strSQL + 'UPDATE CADITE SET ';
        strSQL := strSQL + '       ITE_CODABF = ' + fTrataVazio(qryDados.FieldByName('CODABF').AsString);
        strSQL := strSQL + ' WHERE ITE_CODITE = ' + QuotedStr(FCodIte) + ';';

        If blnLOGCPR And (fTrataVazio(qryDados.FieldByName('CODABF').AsString)<> 'NULL') And (qryDados.FieldByName('CODABF').Value <> qryDados.FieldByName('CODABF').OldValue) Then
        Begin
          strNomeCampo := 'Abreviação ICMS';
          strValorAntigo := VarToStr(qryDados.FieldByName('CODABF').OldValue);
          strValorAtual := VarToStr(qryDados.FieldByName('CODABF').Value);
          TLogAltCadIte.pGravaLogAlteracaoIndividual(FCodIte, strNomeCampo, strValorAntigo, strValorAtual);
        End;
      End;
    End;

    If fCfgSis('TPABPC') = 2 Then
    Begin
      qryDados.Filtered := False;
      qryDados.Filter := '(ALTERADO = 1) AND (PCI_POREMP = 0)';
      qryDados.Filtered := True;
      If Not qryDados.IsEmpty Then
      Begin
        strSQL := strSQL + 'UPDATE CADITE SET ';
        strSQL := strSQL + '       ITE_ABFIPI = ' + fTrataVazio(qryDados.FieldByName('ABFIPI').AsString) + ',';
        strSQL := strSQL + '       ITE_ABFPIS = ' + fTrataVazio(qryDados.FieldByName('ABFPIS').AsString) + ',';
        strSQL := strSQL + '       ITE_ABFCOF = ' + fTrataVazio(qryDados.FieldByName('ABFCOF').AsString);
        strSQL := strSQL + ' WHERE ITE_CODITE = ' + QuotedStr(FCodIte) + ';';

        If blnLOGCPR And (fTrataVazio(qryDados.FieldByName('ABFIPI').AsString)<> 'NULL') And (qryDados.FieldByName('ABFIPI').Value <> qryDados.FieldByName('ABFIPI').OldValue) Then
        Begin
          strNomeCampo := 'Abreviação IPI';
          strValorAntigo := VarToStr(qryDados.FieldByName('ABFIPI').OldValue);
          strValorAtual := VarToStr(qryDados.FieldByName('ABFIPI').Value);
          TLogAltCadIte.pGravaLogAlteracaoIndividual(FCodIte, strNomeCampo, strValorAntigo, strValorAtual);
        End;

        If blnLOGCPR And (fTrataVazio(qryDados.FieldByName('ABFPIS').AsString)<> 'NULL') And (qryDados.FieldByName('ABFPIS').Value <> qryDados.FieldByName('ABFPIS').OldValue) Then
        Begin
          strNomeCampo := 'Abreviação PIS';
          strValorAntigo := VarToStr(qryDados.FieldByName('ABFPIS').OldValue);
          strValorAtual := VarToStr(qryDados.FieldByName('ABFPIS').Value);
          TLogAltCadIte.pGravaLogAlteracaoIndividual(FCodIte, strNomeCampo, strValorAntigo, strValorAtual);
        End;

        If blnLOGCPR And (fTrataVazio(qryDados.FieldByName('ABFCOF').AsString)<> 'NULL') And (qryDados.FieldByName('ABFCOF').Value <> qryDados.FieldByName('ABFCOF').OldValue) Then
        Begin
          strNomeCampo := 'Abreviação COFINS';
          strValorAntigo := VarToStr(qryDados.FieldByName('ABFCOF').OldValue);
          strValorAtual := VarToStr(qryDados.FieldByName('ABFCOF').Value);
          TLogAltCadIte.pGravaLogAlteracaoIndividual(FCodIte, strNomeCampo, strValorAntigo, strValorAtual);
        End;
      End;
    End;


    If strSQL = '' Then
      Exit(True);
    Result := fExecutaSQL(strSQL);
  Finally
    qryDados.Filtered := False;
    qryDados.Filter := '';
    qryDados.AfterScroll := OnScroll;
  End;
end;

procedure TfrmManutencaoAbreviacoesLojas.FormCreate(Sender: TObject);
begin
  inherited;
  qryDados := TZClient.Create(Self, '');
  qryConAbf := fCriaQuery;
  dtsControle.DataSet := qryDados;
  cxTblAbrev.OptionsData.Editing := False;
  qryErros := TZClient.Create(Self, '');

  If fCfgSis('TABPRD', varBoolean) Then
  Begin
    cxCODICM.Options.Editing := False;
    cxCODPIS.Options.Editing := False;
    cxCODCOF.Options.Editing := False;
  End;
end;

procedure TfrmManutencaoAbreviacoesLojas.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryDados);
  FreeAndNil(qryConAbf);
  FreeAndNil(qryErros);
  inherited;
end;

procedure TfrmManutencaoAbreviacoesLojas.pIguala(strCod: string; TipoCodigo: TTipoCodigo);
var strField: String;
    strDescri: String;
    strFieldDes: String;
    strCodCfg: String;
    blnReplicaParaTodos: Boolean;
    blnICMPorEmp,
    blnPisPorEmp: Boolean;
    strEmpSel: String;
begin
  Case TipoCodigo Of
    tcCODICM: Begin
                strField := 'CODABF';
                strFieldDes := 'DESABF';
                strCodCfg := 'CFG_TIPABF';
              End;
    tcCODPIS: Begin
                strField := 'ABFPIS';
                strFieldDes := 'DESPIS';
                strCodCfg := 'CFG_TPABPC';
              End;
    tcCODCOF: Begin
                strField := 'ABFCOF';
                strFieldDes := 'DESCOF';
                strCodCfg := 'CFG_TPABPC';
              End;
    tcCODIPI: Begin
                strField := 'ABFIPI';
                strFieldDes := 'DESIPI';
                strCodCfg := 'CFG_TPABPC';
              End;
  End;

  strDescri := fRetDesc(strCod, TipoCodigo);
  qryDados.AfterScroll := nil;
  qryDados.BeforePost := nil;
  Try
    qryDados.First;
    blnReplicaParaTodos := fVerificaSeReplicaParaTodos(TipoCodigo);

    blnICMPorEmp := False;
    blnPisPorEmp := False;


    If qryDados.Locate('EMP_CODEMP' , VS_StrCodEmp, []) Then
    Begin
      blnICMPorEmp := qryDados.FieldByName('ABF_POREMP').AsInteger = 0;
      blnPisPorEmp := qryDados.FieldByName('PCI_POREMP').AsInteger = 0;

       qryDados.Edit;
       If qryDados.FieldByName(strField).AsString <> strCod Then
          qryDados.FieldByName('ALTERADO').AsInteger := 1;
        qryDados.FieldByName(strField).AsString := strCod;
        qryDados.FieldByName(strFieldDes).AsString := strDescri;
       qryDados.Post;
    end;

    qryDados.First;

    If blnReplicaParaTodos Then
      strEmpSel := fSelecionarEmpresas(strCodCfg);

    While Not qryDados.Eof Do
    Begin
      If (((TipoCodigo = tcCODICM)  And (blnICMPorEmp And (qryDados.FieldByName('ABF_POREMP').AsInteger = 0))) Or
          ((TipoCodigo <> tcCODICM) And (blnPisPorEmp And (qryDados.FieldByName('PCI_POREMP').AsInteger = 0)))) Or
         (blnReplicaParaTodos And (Pos(qryDados.FieldByName('EMP_CODEMP').AsString,  strEmpSel) <> 0))Then
      Begin
        qryDados.Edit;

        If qryDados.FieldByName(strField).AsString <> strCod Then
          qryDados.FieldByName('ALTERADO').AsInteger := 1;
        qryDados.FieldByName(strField).AsString := strCod;
        qryDados.FieldByName(strFieldDes).AsString := strDescri;

        qryDados.Post;
      End;
      qryDados.Next;
    End;
  Finally
    qryDados.AfterScroll := OnScroll;
    qryDados.BeforePost  := OnBeforePost;
  End;
end;

function TfrmManutencaoAbreviacoesLojas.fRetDesc(strCod: string; TipoCodigo: TTipoCodigo): string;
var strField, strChave, strTabela: string;
Begin
  Case TipoCodigo Of
    tcCODICM: Begin
                strField := 'ABF_DESABF';
                strChave:= 'ABF_CODABF';
                strTabela := 'ABFICM';
              End;
    tcCODPIS: strTabela := 'PISSAI';
    tcCODCOF: strTabela := 'COFSAI';
    tcCODIPI: strTabela := 'IPISAI';
  End;
  If  TipoCodigo  <> tcCODICM Then
  Begin
    strField := 'APC_DESCRI';
    strChave := 'APC_CODAPC';
  End;

  qryConAbf.SQL.Clear;
  qryConAbf.SQL.Add('SELECT ' +  strField + ' FROM ' + strTabela + ' WHERE ' + strChave + ' = ' + QuotedStr(strCod));
  qryConAbf.Open;
  If qryConAbf.IsEmpty Then
    Exit('')
  Else
    Exit(qryConAbf.FieldByName(strField).AsString);
End;

function TfrmManutencaoAbreviacoesLojas.fTrataVazio(strValue: string): string;
begin
  If fEmptyStr(strValue) Then
    Result := 'NULL'
  Else
    Result := QuotedStr(strValue);
end;

function TfrmManutencaoAbreviacoesLojas.fValidaRegistros: Boolean;

   procedure pAdicionaErro(strErro: String);
   Begin
     qryErros.Insert;
     qryErros.FieldByName('EMP_CODEMP').AsString := qryDados.FieldByName('EMP_CODEMP').AsString;
     qryErros.FieldByName('EMPRESA').AsString := qryDados.FieldByName('EMPRESA').AsString;
     qryErros.FieldByName('ERRO').AsString := strErro;
     qryErros.Post;
   End;

begin
  Try
    pCarregaQryErro;

    qryDados.Filtered := False;
    qryDados.Filter := '(PCI_POREMP = 1)OR(ABF_POREMP = 1)';
    qryDados.Filtered := True;

    qryDados.First;
    While Not qryDados.Eof do
    Begin
      If qryDados.FieldByName('ABF_POREMP').AsInteger = 1 Then
      Begin
        If qryDados.FieldByName('CODABF').AsString = '' Then
        Begin
          pAdicionaErro('A Abreviação Fiscal deve ser preenchida.');
        End
        Else If (strCodNcm <> '') And (Not fAbreviacaoIcmsPermitidaParaNCM(qryDados.FieldByName('CODABF').AsString, strCodNcm, strCodExc)) Then
        Begin
          pAdicionaErro('A Abreviação Fiscal não é permitida para o NCM ' + strCodNcm + '.');
        End;
      End;

      If (qryDados.FieldByName('PCI_POREMP').AsInteger = 1) Then
      Begin
        If (Not (qryDados.FieldByName('SIMPAU').AsString = 'S')) And (qryDados.FieldByName('UTI_PC').AsString = 'S') Then
        Begin
          If qryDados.FieldByName('ABFPIS').AsString = '' Then
            pAdicionaErro('A Abreviação de PIS deve ser preenchida.')
          Else If (strCodNcm <> '') And (Not fAbreviacaoPisPermitidaParaNCM(qryDados.FieldByName('ABFPIS').AsString, strCodNcm, strCodExc)) Then
            pAdicionaErro('A Abreviação de PIS não é permitida para o NCM ' + strCodNcm + '.');

          If qryDados.FieldByName('ABFCOF').AsString = '' Then
            pAdicionaErro('A Abreviação de COFINS deve ser preenchida.')
          Else If (strCodNcm <> '') And (Not fAbreviacaoCofinsPermitidaParaNCM(qryDados.FieldByName('ABFCOF').AsString, strCodNcm, strCodExc)) Then
            pAdicionaErro('A Abreviação de COFINS não é permitida para o NCM ' + strCodNcm + '.');
        End;

        If qryDados.FieldByName('ABFIPI').AsString = '' Then
        Begin
//          pAdicionaErro('A Abreviação de IPI deve ser preenchida.');
        End
        Else If (strCodNcm <> '') And (Not fAbreviacaoIpiPermitidaParaNCM(qryDados.FieldByName('ABFIPI').AsString, strCodNcm, strCodExc)) Then
        Begin
          pAdicionaErro('A Abreviação de IPI não é permitida para o NCM ' + strCodNcm + '.');
        End;

      End;
      qryDados.Next;
    End;
    Result := qryErros.IsEmpty;
    qryDados.Filtered := False;
  Except
    Result := False
  End;
end;

function TfrmManutencaoAbreviacoesLojas.fVerificaSeReplicaParaTodos(TipoCodigo: TTipoCodigo): Boolean;
var strField: String;
    strFieldDes: String;
    strDescri: String;

    intTotReg: integer;
begin
  Case TipoCodigo Of
    tcCODICM: Begin
                strField := 'CODABF';
                strDescri := 'Abreviação de ICMS';
                strFieldDes := 'DESABF';
              End;
    tcCODPIS: Begin
                strField := 'ABFPIS';
                strDescri := 'Abreviação de PIS';
                strFieldDes := 'DESPIS';
              End;
    tcCODCOF: Begin
                strField := 'ABFCOF';
                strDescri := 'Abreviação de COFINS';
                strFieldDes := 'DESCOF';
              End;
    tcCODIPI: Begin
                strField := 'ABFIPI';
                strDescri := 'Abreviação de IPI';
                strFieldDes := 'DESIPI';
              End;
  End;
  intTotReg := qryDados.RecordCount;
  qryDados.Filtered := False;
  qryDados.Filter :=  strField + ' = ' + QuotedStr('');
  qryDados.Filtered := True;
  If qryDados.RecordCount = intTotReg Then
    Result := True
  Else
    Result := fPergunta('Deseja replicar os dados da ' + strDescri + ' alterada para todas as empresas?');
  qryDados.Filtered := False;
  qryDados.Filter :=  '';
end;

procedure TfrmManutencaoAbreviacoesLojas.OnScroll(DataSet: TDataSet);
begin
  If cxTblAbrev.OptionsData.Editing Then
  Begin
    cxCODICM.Options.Editing := qryDados.FieldByName('ABF_POREMP').AsInteger = 1;
    cxCODPIS.Options.Editing := qryDados.FieldByName('PCI_POREMP').AsInteger = 1;
    cxCODCOF.Options.Editing := qryDados.FieldByName('PCI_POREMP').AsInteger = 1;
    cxCODIPI.Options.Editing := qryDados.FieldByName('PCI_POREMP').AsInteger = 1;

    btnReplicaDados.Enabled := (cxCODICM.Options.Editing And cxCODICM.Focused) Or
                               (cxCODPIS.Options.Editing And cxCODPIS.Focused) Or
                               (cxCODCOF.Options.Editing And cxCODCOF.Focused) Or
                               (cxCODIPI.Options.Editing And cxCODIPI.Focused);
  end;
end;

procedure TfrmManutencaoAbreviacoesLojas.pAtualizaAbreviacoesIMendes(ACodAbf, ADesAbf,
  ACodEmp: String; blnReplicaTipAbf_1: Boolean);
begin
  qryDados.BeforePost := nil;
  qryDados.AfterPost := nil;
  Try
    qryDados.First;
    qryDados.Locate('EMP_CODEMP', ACodEmp, []);
    qryDados.Edit;
    qryDados.FieldByName('CODABF').AsString :=  ACodAbf;
    qryDados.FieldByName('DESABF').AsString :=  ADesAbf;
    qryDados.Post;

    If blnReplicaTipAbf_1 Then
    Begin
      qryDados.First;
      While not qryDados.Eof Do
      Begin
        If qryDados.FieldByName('EMP_CODEMP').AsString <> ACodEmp then
          If qryDados.FieldByName('ABF_POREMP').AsString = '0' Then
          Begin
            qryDados.Edit;
            qryDados.FieldByName('CODABF').AsString :=  ACodAbf;
            qryDados.FieldByName('DESABF').AsString :=  ADesAbf;
            qryDados.Post;
          End;
        qryDados.Next;
      End;
    End;
  Finally
    qryDados.BeforePost := OnBeforePost;
    qryDados.AfterPost := OnAfterPost;
  End;
end;

procedure TfrmManutencaoAbreviacoesLojas.pCarrega(strCodIte: String; blnHeranca: Boolean = False; strAbfPis: string = ''; strAbfCof: string = '');
begin
  qryDados.qryQuery.SQL.Clear;
  if Not fEmptyStr(strCodIte)Then
  Begin
    qryDados.qryQuery.SQL.Add('SELECT');
    qryDados.qryQuery.SQL.Add(' IF(ABF.SIS_VALCFG = 1, C.ITE_CODABF, I.ITE_CODABF) AS CODABF,');
    qryDados.qryQuery.SQL.Add(' (SELECT ABF_DESABF FROM ABFICM');
    qryDados.qryQuery.SQL.Add('   WHERE ABF_CODABF = IF(ABF.SIS_VALCFG = 1, C.ITE_CODABF, I.ITE_CODABF) AND ABF_ESTADO = CID_ESTADO LIMIT 1) AS DESABF,');
    qryDados.qryQuery.SQL.Add(' IF(PCI.SIS_VALCFG = 1, C.ITE_ABFPIS, I.ITE_ABFPIS) AS ABFPIS,');
    qryDados.qryQuery.SQL.Add(' (SELECT APC_DESCRI FROM PISSAI');
    qryDados.qryQuery.SQL.Add('   WHERE APC_CODAPC = IF(PCI.SIS_VALCFG = 1, C.ITE_ABFPIS, I.ITE_ABFPIS) LIMIT 1) AS DESPIS,');
    qryDados.qryQuery.SQL.Add(' IF(PCI.SIS_VALCFG = 1, C.ITE_ABFCOF, I.ITE_ABFCOF) AS ABFCOF,');
    qryDados.qryQuery.SQL.Add(' (SELECT APC_DESCRI FROM COFSAI');
    qryDados.qryQuery.SQL.Add('   WHERE APC_CODAPC = IF(PCI.SIS_VALCFG = 1, C.ITE_ABFCOF, I.ITE_ABFCOF) LIMIT 1) AS DESCOF,');
    qryDados.qryQuery.SQL.Add(' IF(PCI.SIS_VALCFG = 1, C.ITE_ABFIPI, I.ITE_ABFIPI) AS ABFIPI,');
    qryDados.qryQuery.SQL.Add(' (SELECT APC_DESCRI FROM IPISAI');
    qryDados.qryQuery.SQL.Add('   WHERE APC_CODAPC = IF(PCI.SIS_VALCFG = 1, C.ITE_ABFIPI, I.ITE_ABFIPI) LIMIT 1) AS DESIPI,');
    qryDados.qryQuery.SQL.Add(' EMP_CODEMP,');
    qryDados.qryQuery.SQL.Add(' CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP) AS EMPRESA,');
    qryDados.qryQuery.SQL.Add(' IF(PCI.SIS_VALCFG = 2, 1, 0) AS PCI_POREMP,');
    qryDados.qryQuery.SQL.Add(' IF(ABF.SIS_VALCFG = 2, 1, 0) AS ABF_POREMP,');
    If blnHeranca Then
      qryDados.qryQuery.SQL.Add(' 1 AS ALTERADO,')
    Else
      qryDados.qryQuery.SQL.Add(' 0 AS ALTERADO,');

    qryDados.qryQuery.SQL.Add(' SPA.SIS_VALCFG AS SIMPAU,');
    qryDados.qryQuery.SQL.Add(' UPC.SIS_VALCFG AS UTI_PC ');

    qryDados.qryQuery.SQL.Add('FROM CADEMP');

    qryDados.qryQuery.SQL.Add('  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ');

    qryDados.qryQuery.SQL.Add('  INNER JOIN CFGSIS ABF ON ABF.SIS_CODEMP = EMP_CODEMP AND ABF.SIS_CODCFG = "CFG_TIPABF"');
    qryDados.qryQuery.SQL.Add('  INNER JOIN CFGSIS PCI ON PCI.SIS_CODEMP = EMP_CODEMP AND PCI.SIS_CODCFG = "CFG_TPABPC"');

    qryDados.qryQuery.SQL.Add('    INNER JOIN CFGSIS SPA ON SPA.SIS_CODEMP = EMP_CODEMP AND SPA.SIS_CODCFG = "CFG_SIMPAU"');
    qryDados.qryQuery.SQL.Add('    INNER JOIN CFGSIS UPC ON UPC.SIS_CODEMP = EMP_CODEMP AND UPC.SIS_CODCFG = "CFG_SPEDPC"');

    qryDados.qryQuery.SQL.Add('   LEFT JOIN CADITE C ON C.ITE_CODITE = ' + QuotedStr(strCodIte));
    qryDados.qryQuery.SQL.Add('  INNER JOIN ITEGER I ON C.ITE_CODITE = I.ITE_CODITE AND I.ITE_CODEMP = EMP_CODEMP');

    qryDados.qryQuery.SQL.Add('  ORDER BY EMP_CODEMP ');

    FCodIte := strCodIte;
  End
  Else
  Begin
    qryDados.qryQuery.SQL.Add('SELECT');
    qryDados.qryQuery.SQL.Add('  CAST("" AS CHAR('+ IntToStr(fTamCodAbfIcm) + ')) AS CODABF,');
    qryDados.qryQuery.SQL.Add('  CAST("" AS CHAR(255)) AS DESABF,');
    qryDados.qryQuery.SQL.Add('  CAST(IF(PCI.SIS_VALCFG = 2, IFNULL(PIS.SIS_VALCFG, ""), "'+strAbfPis+'") AS CHAR(3)) AS ABFPIS,');
    qryDados.qryQuery.SQL.Add('  CAST(IF(PCI.SIS_VALCFG = 2, (SELECT APC_DESCRI FROM  PISSAI WHERE APC_CODAPC = PIS.SIS_VALCFG GROUP BY APC_CODAPC), "'+strAbfPis+'") AS CHAR(255)) AS DESPIS,');
    qryDados.qryQuery.SQL.Add('  CAST(IF(PCI.SIS_VALCFG = 2, IFNULL(COF.SIS_VALCFG, ""), "'+strAbfCof+'") AS CHAR(3)) AS ABFCOF,');
    qryDados.qryQuery.SQL.Add('  CAST(IF(PCI.SIS_VALCFG = 2, (SELECT APC_DESCRI FROM  COFSAI WHERE APC_CODAPC = COF.SIS_VALCFG GROUP BY APC_CODAPC), "'+strAbfCof+'") AS CHAR(255)) AS DESCOF,');
    qryDados.qryQuery.SQL.Add('  CAST("" AS CHAR(3)) AS ABFIPI,');
    qryDados.qryQuery.SQL.Add('  CAST("" AS CHAR(255)) AS DESIPI,');
    qryDados.qryQuery.SQL.Add('  EMP_CODEMP,');
    qryDados.qryQuery.SQL.Add('  CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP) AS EMPRESA,');
    qryDados.qryQuery.SQL.Add('  IF(PCI.SIS_VALCFG = 2, 1, 0) AS PCI_POREMP,');
    qryDados.qryQuery.SQL.Add('  IF(ABF.SIS_VALCFG = 2, 1, 0) AS ABF_POREMP,');
    qryDados.qryQuery.SQL.Add('  0 AS ALTERADO,');
    qryDados.qryQuery.SQL.Add('  SPA.SIS_VALCFG AS SIMPAU,');
    qryDados.qryQuery.SQL.Add('  UPC.SIS_VALCFG AS UTI_PC');
    qryDados.qryQuery.SQL.Add('FROM');
    qryDados.qryQuery.SQL.Add('  CADEMP');
    qryDados.qryQuery.SQL.Add('  INNER JOIN CFGSIS ABF ON ABF.SIS_CODEMP = EMP_CODEMP AND ABF.SIS_CODCFG = "CFG_TIPABF"');
    qryDados.qryQuery.SQL.Add('  INNER JOIN CFGSIS PCI ON PCI.SIS_CODEMP = EMP_CODEMP AND PCI.SIS_CODCFG = "CFG_TPABPC"');
    qryDados.qryQuery.SQL.Add('  INNER JOIN CFGSIS SPA ON SPA.SIS_CODEMP = EMP_CODEMP AND SPA.SIS_CODCFG = "CFG_SIMPAU"');
    qryDados.qryQuery.SQL.Add('  INNER JOIN CFGSIS UPC ON UPC.SIS_CODEMP = EMP_CODEMP AND UPC.SIS_CODCFG = "CFG_SPEDPC"');
    qryDados.qryQuery.SQL.Add('  INNER JOIN CFGSIS PIS ON PIS.SIS_CODEMP = EMP_CODEMP AND PIS.SIS_CODCFG = "CFG_PADPIS"');
    qryDados.qryQuery.SQL.Add('  INNER JOIN CFGSIS COF ON COF.SIS_CODEMP = EMP_CODEMP AND COF.SIS_CODCFG = "CFG_PADCOF"');

    qryDados.qryQuery.SQL.Add('  ORDER BY EMP_CODEMP');
    FCodIte := '';

  End;

  qryDados.fAbreClient(True, 'TfrmManutencaoAbreviacoesLojas.pMontaSQL');

  cxTblAbrev.OptionsData.Editing := False;

  qryDados.AfterScroll := OnScroll;
  qryDados.BeforePost := OnBeforePost;
  qryDados.AfterPost  := OnAfterPost;
  pCarregaQryErro;

end;

procedure TfrmManutencaoAbreviacoesLojas.pCarregaQryErro;
Begin
  qryErros.qryQuery.SQL.Clear;
  qryErros.qryQuery.SQL.Add('SELECT ');
  qryErros.qryQuery.SQL.Add('  EMP_CODEMP,');
  qryErros.qryQuery.SQL.Add('  CAST("" AS CHAR(300)) AS ERRO,');
  qryErros.qryQuery.SQL.Add('  CONCAT(EMP_CODEMP, " - ", EMP_NOMEMP) AS EMPRESA ');
  qryErros.qryQuery.SQL.Add('  FROM CADEMP');
  qryErros.qryQuery.SQL.Add(' WHERE FALSE');


  qryErros.fAbreClient(True, 'TfrmManutencaoAbreviacoesLojas.pCriaQryErro');
end;



procedure TfrmManutencaoAbreviacoesLojas.pExibeMensagem;
begin
  TfrmManutencaoAbreviacoesLojasLog.fShowModal(qryErros);
end;

procedure TfrmManutencaoAbreviacoesLojas.pHabilitaEdicao(blnHabilita: Boolean);
begin
  cxTblAbrev.OptionsData.Editing := blnHabilita;
  pnlLegenda.Enabled := blnHabilita;
end;

procedure TfrmManutencaoAbreviacoesLojas.pSetPainel(APanel: TPanel);
begin
  Self.pnlGrid.Dock(APanel, APanel.BoundsRect);
end;


procedure TfrmManutencaoAbreviacoesLojas.OnAfterPost(DataSet: TDataSet);
begin
  if qryDados.FieldByName('EMP_CODEMP').AsString =  VS_StrCodEmp then
  Begin
    FCampoAbvIcms.Field.AsString   := qryDados.FieldByName('CODABF').AsString;
    FCampoAbvPis.Field.AsString    := qryDados.FieldByName('ABFPIS').AsString;
    FCampoAbvCofins.Field.AsString := qryDados.FieldByName('ABFCOF').AsString;
    FCampoAbvIpi.Field.AsString    := qryDados.FieldByName('ABFIPI').AsString;

    FCampoDesAbvIcms.Text   := qryDados.FieldByName('DESABF').AsString;
    FCampoDesAbvPis.Text    := qryDados.FieldByName('DESPIS').AsString;
    FCampoDesAbvCofins.Text := qryDados.FieldByName('DESCOF').AsString;
    FCampoDesAbvIpi.Text    := qryDados.FieldByName('DESIPI').AsString;
  End;

  qryDados.AfterScroll := OnScroll;
end;


procedure TfrmManutencaoAbreviacoesLojas.OnBeforePost(DataSet: TDataSet);
  procedure pValidaCampo(strCampoCodigo, strCampoDescricao, strAbrev: String; TipoCodigo: TTipoCodigo);
  Begin
    If qryDados.FieldByName(strCampoCodigo).NewValue <> qryDados.FieldByName(strCampoCodigo).OldValue Then
    Begin
      qryDados.FieldByName(strCampoCodigo).AsString := fPadL(qryDados.FieldByName(strCampoCodigo).AsString, IIf(TipoCodigo=tcCODICM, fTamCodAbfIcm, 3),'0');
      qryDados.FieldByName(strCampoDescricao).AsString := fRetDesc(qryDados.FieldByName(strCampoCodigo).NewValue, TipoCodigo);
      If qryDados.FieldByName(strCampoDescricao).AsString = '' Then
      begin
        fMensagem('Atenção', 'Código informado para ' + strAbrev + ' não identificado.', ['&OK']);
        qryDados.FieldByName(strCampoCodigo).AsString := '';
      End;
    End
    Else If qryDados.FieldByName(strCampoCodigo).OldValue <> null Then
    Begin
      qryDados.FieldByName(strCampoDescricao).AsString := fRetDesc(qryDados.FieldByName(strCampoCodigo).NewValue, TipoCodigo);
    End;

  End;
  function fVerificaSeTeveAlteracao: Boolean;
  Begin
    Result := (qryDados.FieldByName('CODABF').NewValue <> qryDados.FieldByName('CODABF').OldValue) Or
              (qryDados.FieldByName('CODABF').Value <> qryDados.FieldByName('CODABF').OldValue) Or
              (qryDados.FieldByName('ABFPIS').NewValue <> qryDados.FieldByName('ABFPIS').OldValue) Or
              (qryDados.FieldByName('ABFPIS').Value <> qryDados.FieldByName('ABFPIS').OldValue) Or
              (qryDados.FieldByName('ABFCOF').NewValue <> qryDados.FieldByName('ABFCOF').OldValue) Or
              (qryDados.FieldByName('ABFCOF').Value <> qryDados.FieldByName('ABFCOF').OldValue) Or
              (qryDados.FieldByName('ABFIPI').NewValue <> qryDados.FieldByName('ABFIPI').OldValue) Or
              (qryDados.FieldByName('ABFIPI').Value <> qryDados.FieldByName('ABFIPI').OldValue);

  End;
begin
  qryDados.AfterScroll := nil;
  pValidaCampo('CODABF', 'DESABF', 'Abreviação ICMS', tcCODICM);
  pValidaCampo('ABFPIS', 'DESPIS', 'Abreviação PIS', tcCODPIS);
  pValidaCampo('ABFCOF', 'DESCOF', 'Abreviação COFINS', tcCODCOF);
  pValidaCampo('ABFIPI', 'DESIPI', 'Abreviação IPI', tcCODIPI);

  If fVerificaSeTeveAlteracao Then
    qryDados.FieldByName('ALTERADO').AsInteger := 1
  Else
    qryDados.FieldByName('ALTERADO').AsInteger := 0;

end;

function TfrmManutencaoAbreviacoesLojas.fSelecionarEmpresas(strCodCfg: String): String;
Var
  frmSelEmpresas: TfrmSelEmpresas;
Begin
  pCriarFormularios(TfrmSelEmpresas, frmSelEmpresas);
  Try
    frmSelEmpresas.strCodEmp := VS_strCodEmp;
    Result := frmSelEmpresas
      .pAbreEmpresaTipAbf(strCodCfg)
      .pShowModal
      .fRetSelecionadas;
  Finally
    pFreeAndNil(frmSelEmpresas);
  End;
End;

end.



