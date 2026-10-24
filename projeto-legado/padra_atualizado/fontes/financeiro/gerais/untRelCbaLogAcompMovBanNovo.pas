unit untRelCbaLogAcompMovBanNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem, cxGrid, UniClientDataSet, StrUtils,
  cxLookAndFeels, cxLookAndFeelPainters,
  cxNavigator, frxClass, frxExportCSVTestabilidade, System.UITypes,
  cxProgressBar, untClassPanelCx, System.ImageList,
  Vcl.ImgList, Datasnap.Provider, DBAccess, Datasnap.DBClient, untTypesSistema, untIFuncoes, untGravando,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList,
  untFramePlanoDeContasMaskEdit;

type
  TfrmRelCbaLogAcompMovBanNovo = class(TfrmPai)
    pnlHeader: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    Label27: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodPortador: TEditFocus;
    edtNomPortador: TEditFocus;
    edtNumSeq: TEditFocus;
    dbgConsultaDBTableView1: TcxGridDBTableView;
    dbgConsultaLevel1: TcxGridLevel;
    dbgConsulta: TcxGrid;
    dbgConsultaDBTableView1CTB_DTALOG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_HORLOG: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_DESCRI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_NOMFRM: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_OPELOG: TcxGridDBColumn;
    cxsrConsulta: TcxStyleRepository;
    dbgConsultaDBTableView1Lanc: TcxGridDBColumn;
    dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label2: TLabel;
    cxImageList: TcxImageList;
    cdsConsulta: TUniClientDataSet;
    dspConsulta: TUniDataSetProvider;
    btnConsultar: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    Shp_inferior: TShape;
    lblCampoAlterados2: TLabel;
    dtsConsulta: TDataSource;
    dbgConsultaDBTableView1CTB_CODCTA: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_CODPOR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_DTALAN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_HORLAN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_NUMDOC: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_CREDEB: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_VALLAN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_HIST01: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_HIST02: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_CODEMP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_CODCLI: TcxGridDBColumn;
    dbgConsultaDBTableViewCTB_CODFOR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_SEQBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_PARCEL: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_EMPDUP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_NUMDUP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_SERIE_: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_CODEVE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_DTACON: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_OPECON: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_SEQCTP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_DOCBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_SEQTRF: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_CODVEL: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_PAGCON: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_HORCON: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_ORIGEM: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_COMPET: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_CODCHQ: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_CODCAR: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_OCOIGN: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_IGNORA: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_NOMEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_DTAEXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_HOREXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_VEREXE: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_ARQIMP: TcxGridDBColumn;
    dbgConsultaDBTableView1CTB_SEQLAN: TcxGridDBColumn;
    Label6: TLabel;
    edtNomeArquivo: TEditFocus;
    rdgData: TRadioGroup;
    rdgOrdernacao: TRadioGroup;
    btnCalculo: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    gpbRegcomAlteracao: TGroupBox;
    Label3: TLabel;
    chkRegComAlteracao: TCheckBox;
    cmbInfRegAlterado: TComboBox;
    btnGeraCSV: TBitBtnLocked;
    procedure edtCodPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgConsultaDBTableView1CustomDrawGroupCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnCalculoClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumSeqExit(Sender: TObject);
    procedure btnGeraCSVClick(Sender: TObject);
    procedure chkRegComAlteracaoClick(Sender: TObject);
  private
    { Private declarations }
    intCor     : Integer;

    procedure pFechaConsulta;
    procedure pSetFilterDefault;
    procedure pMascaraValor;
    function fGetSql: String;
    function fAbreConsulta(cxProgress: TcxProgressBar = Nil): Boolean;
    function fSetParametros: Boolean;

    function MouseShowCursor(const Show: boolean): boolean;
    procedure pDefineAlteracoes;
    function DefineAlteracoes(pgbProgresso: TcxProgressBar): Boolean;
    function fCarregaCampos(pgbProgresso: TcxProgressBar): Boolean;
    procedure StepStatusSelecao(pgbStatus: TcxProgressBar);
    function fGeraCSV(cxProgress: TcxProgressBar): Boolean;
    function fRetornaListaRegAntesAlteracao(cdsGen: TDataSet): String;
    procedure pVerificaAplicaFiltroRegComAlteracao;
    procedure VerificaSeTemRegistros;
  public
    { Public declarations }
    blnVeioMovimentacao: Boolean;
    qryConsulta: TUniQuery;
  procedure pCarregaCampos;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmRelCbaLogAcompMovBanNovo.btnCalculoClick(Sender: TObject);
begin
  inherited;
  fMensagem('Informação', 'Movimentações bancárias que lançam movimento contrário ' + #13#10 +
                            'são geradas com um novo sequencial de lançamento, ' + #13#10 +
                            'portanto serão exibidas separadamente.', ['&Ok'], 1, False, 2);
end;

procedure TfrmRelCbaLogAcompMovBanNovo.btnConsultarClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;
  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.pgbStatus.Visible   := False;
      frmAguarde.blnDesabilitaMouse  := True;
      frmAguarde.lblGravando.Caption := 'Aguarde Carregando Títulos...';
      frmAguarde.fExecutarAcao := fAbreConsulta;
      frmAguarde.ShowModal;
      VerificaSeTemRegistros();
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'frmRelCbaLogAcompMovBanNovo.fAbreConsulta');
  End;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.btnGeraCSVClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;
  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.lblGravando.Caption := 'Gerando Arquivo...';
      frmAguarde.fExecutarAcao := fGeraCSV;
      frmAguarde.ShowModal;
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
  End;
end;

Procedure TfrmRelCbaLogAcompMovBanNovo.VerificaSeTemRegistros();
Begin
  If Not dtsConsulta.DataSet.IsEmpty Then
  begin
     dbgConsultaDBTableView1.DataController.FocusedRowIndex := 0;
     pSetFocus(dbgConsulta);
  End
  Else
  Begin
    MouseShowCursor(True);
    fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k']);
    pSetFocus(edtNumSeq);
  end;
End;

function TfrmRelCbaLogAcompMovBanNovo.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
  Var
    svdCsv: TSaveDialog;
    strLinha,
    strNomArq: String;
    stlCsv: TStringList;

    procedure pStepStatusGravacao;
    Begin
      If Assigned(cxProgress) Then
      Begin
        cxProgress.Position := cxProgress.Position + 1;
        Application.ProcessMessages;
      End;
    End;

    procedure pInfoStatusGravacao(strInformacao: String);
    Begin
      If Assigned(cxProgress) And (GetParentForm(cxProgress).FindComponent('lblGravando') <> Nil) Then
      Begin
        TLabel(GetParentForm(cxProgress).FindComponent('lblGravando')).Caption := strInformacao;
        Application.ProcessMessages;
      End;
    End;
begin
  Result := True;

  pInfoStatusGravacao('Gerando arquivo CSV. Aguarde...');

  cxProgress.Position := 0;
  cxProgress.Properties.Max := cdsConsulta.RecordCount;

  svdCsv := TSaveDialog.Create(Nil);
  svdCsv.Filter := 'Arquivo CSV|*.csv';
  svdCsv.DefaultExt := 'csv';

  If svdCsv.Execute Then
  Begin
    strNomArq := svdCsv.FileName;

    If Not fEmptyStr(strNomArq) Then
    Begin
      stlCsv := TStringList.Create;

      stlCsv.Clear;

      With cdsConsulta Do
      Begin
        DisableControls;

        First;

        strLinha := 'DATA LOG.;HORA LOG.;DESCRIÇÃO;NOME DO FORMULÁRIO;CÓD. OPERADOR LOG;PL. CONTAS;CÓD. PORTADOR;'+
                    'SEQ. LANÇAMENTO;DTA. LANÇAMENTO;HRA. LANÇAMENTO;ARQUIVO IMPORTAÇÃO;NUM. DOC;C/D;VALOR;HISTÓRICO 1;HISTÓRICO 2;'+
                    'EMPRESA;CLIENTE;FORNECEDOR;SEQUENCIAL DA BAIXA;PARCELA;EMP. DUPLIC.;DUPLICATA;SERIE;CTR. CUSTO;DTA. CONCILIAÇÃO;'+
                    'OPE. CONCILIAÇÃO;SEQ. CTA. A PAGAR;DOC. DE BAIXA;SEQ. DE TRANSFERÊNCIA;COD. DE CONTROLE ANTERIOR;SEQ. DE CONTROLE;'+
                    'HRO. DA CONCILIAÇÃO;ORIG. DO LANÇ.;COMPETÊNCIA;COD. CHEQUE;CÓD. CARTÃO;CÓD. OCORRÊNCIA;IGNORADO?;LANÇAMENTO;'+
                    'NOME EXE;DATA EXE;HORA EXE;VERSÃO EXE';

        stlCsv.Add(strLinha);

        While Not Eof Do
        Begin
          strLinha := FormatDateTime('dd/mm/yyyy', FieldByName('CTB_DTALOG').AsDateTime) + ';' +
                      FormatDateTime('HH:mm:ss'  , FieldByName('CTB_HORLOG').AsDateTime) + ';' +
                      FieldByName('CTB_DESCRI').AsString + ';' +
                      FieldByName('CTB_NOMFRM').AsString + ';' +
                      FieldByName('CTB_OPELOG').AsString + ';' +
                      FieldByName('CTB_CODCTA').AsString + ';' +
                      FieldByName('CTB_CODPOR').AsString + ';' +
                      FieldByName('CTB_SEQLAN').AsString + ';' +
                      FormatDateTime('dd/mm/yyyy', FieldByName('CTB_DTALAN').AsDateTime) + ';' +
                      FormatDateTime('HH:mm:ss'  , FieldByName('CTB_HORLAN').AsDateTime) + ';' +
                      FieldByName('CTB_ARQIMP').AsString + ';' +
                      FieldByName('CTB_NUMDOC').AsString + ';' +
                      FieldByName('CTB_CREDEB').AsString + ';' +
                      FormatFloat('#,##0.00',FieldByName('CTB_VALLAN').AsFloat) + ';' +
                      ReplaceStr(ReplaceStr((ReplaceStr(FieldByName('CTB_HIST01').AsString, '<<csq>>', ' ')), #13#10, ' '),#10, ' ') + ';' +
                      ReplaceStr(ReplaceStr((ReplaceStr(FieldByName('CTB_HIST02').AsString, '<<csq>>', ' ')), #13#10, ' '),#10, ' ') + ';' +
                      FieldByName('CTB_CODEMP').AsString + ';' +
                      FieldByName('CTB_CODCLI').AsString + ';' +
                      FieldByName('CTB_CODFOR').AsString + ';' +
                      FieldByName('CTB_SEQBAI').AsString + ';' +
                      FieldByName('CTB_PARCEL').AsString + ';' +
                      FieldByName('CTB_EMPDUP').AsString + ';' +
                      FieldByName('CTB_NUMDUP').AsString + ';' +
                      FieldByName('CTB_SERIE_').AsString + ';' +
                      FieldByName('CTB_CODEVE').AsString + ';' +
                      IfThen(FieldByName('CTB_DTACON').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTB_DTACON').AsDateTime)) + ';' +
                      FieldByName('CTB_OPECON').AsString + ';' +
                      FieldByName('CTB_SEQCTP').AsString + ';' +
                      FieldByName('CTB_DOCBAI').AsString + ';' +
                      FieldByName('CTB_SEQTRF').AsString + ';' +
                      FieldByName('CTB_CODVEL').AsString + ';' +
                      FieldByName('CTB_PAGCON').AsString + ';' +
                      IfThen(FieldByName('CTB_HORCON').Value <= 0, '', FormatDateTime('HH:mm:ss', FieldByName('CTB_HORCON').AsDateTime)) + ';' +
                      FieldByName('CTB_ORIGEM').AsString + ';' +
                      FieldByName('CTB_COMPET').AsString + ';' +
                      FieldByName('CTB_CODCHQ').AsString + ';' +
                      FieldByName('CTB_CODCAR').AsString + ';' +
                      FieldByName('CTB_OCOIGN').AsString + ';' + // CODIGO DA OCORRENCIA;
                      FieldByName('CTB_IGNORA').AsString + ';' +
                      FieldByName('LANC').AsString+';'+
                      FieldByName('CTB_NOMEXE').AsString+';'+
                      IfThen(FieldByName('CTB_DTAEXE').Value <= 0, '', FormatDateTime('dd/mm/yyyy', FieldByName('CTB_DTAEXE').AsDateTime)) + ';' +
                      IfThen(FieldByName('CTB_HOREXE').Value <= 0, '', FormatDateTime('HH:mm:ss'  , FieldByName('CTB_HOREXE').AsDateTime)) + ';' +
                      FieldByName('CTB_VEREXE').AsString;

          stlCsv.Add(strLinha);
          pStepStatusGravacao;

          Next;
        End;
        EnableControls;
      End;

      stlCsv.SaveToFile(strNomArq);
      FreeAndNil(stlCsv);

      fMensagem('','Arquivo CSV gerado com sucesso!!', ['&O K']);
    End;
  End;

  FreeAndNil(svdCsv);
end;

procedure TfrmRelCbaLogAcompMovBanNovo.chkRegComAlteracaoClick(Sender: TObject);
begin
  inherited;
  If chkRegComAlteracao.checked Then
     cmbinfRegAlterado.enabled := True
  Else
  Begin
     cmbinfRegAlterado.enabled := False;
     cmbinfRegAlterado.ItemIndex := -1;
  End;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.dbgConsultaDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (AViewInfo.GridRecord.Values[dbgConsultaDBTableView1Alteracoes.Index] <> null) And
     (Pos(TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName,
          AViewInfo.GridRecord.Values[dbgConsultaDBTableView1Alteracoes.Index]) > 0) then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $4433CC
    Else
      ACanvas.Brush.Color := $8070FF;
  end
  Else
  Begin
    If (not AViewInfo.Selected) Then
    Begin
      If Odd(AViewInfo.GridRecord.Index) Then
        ACanvas.Brush.Color := intCor
      Else
        ACanvas.Brush.Color := clWindow;
    End;
  End;

  ACanvas.Font.Color := clBlack;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.dbgConsultaDBTableView1CustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clSkyBlue;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
end;

function TfrmRelCbaLogAcompMovBanNovo.DefineAlteracoes(pgbProgresso: TcxProgressBar): Boolean;
var
  arrRef: Array of String;
  strDupAtual: String;
  strCamposDif: String;
  intIndex: Integer;
  icont : Integer;
begin
  cdsConsulta.DisableControls;
  SetLength(arrRef, cdsConsulta.Fields.Count);

  With cdsConsulta Do
  Begin
    First;
    strDupAtual := '';
    icont := 0;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := RecordCount;

    While not Eof Do
    Begin

      icont := icont + 1;

      Edit;
      FieldByName('CONTADOR').AsString := inttostr(icont);
      Post;

      If (strDupAtual <> FieldByName('LANC').AsString) Then
      Begin
        strDupAtual := FieldByName('LANC').AsString;
        for intIndex := 0 to Fields.Count - 1 do
          arrRef[intIndex] := Fields[intIndex].AsString;
      End
      Else
      Begin
        strCamposDif := '/';
        for intIndex := 0 to Fields.Count - 1 do
          If (arrRef[intIndex] <> Fields[intIndex].AsString) And
             (Fields[intIndex].FieldName <> 'AUTOINCREM') And
             (Fields[intIndex].FieldName <> 'CTB_DTALOG') And
             (Fields[intIndex].FieldName <> 'CTB_HORLOG') And
             (Fields[intIndex].FieldName <> 'CTB_DESCRI') And
             (Fields[intIndex].FieldName <> 'CTB_NOMFRM') And
             (Fields[intIndex].FieldName <> 'CTB_OPELOG') Then
            strCamposDif := strCamposDif + Fields[intIndex].FieldName + '/';

        Edit;
        FieldByName('ALTERACOES').AsString := strCamposDif;
        FieldByName('CONT_ANTERIOR').AsString := inttostr(iCont-1);
        Post;

        for intIndex := 0 to Fields.Count - 1 do
          arrRef[intIndex] := Fields[intIndex].AsString;
      End;
      Next;

      StepStatusSelecao(pgbProgresso);
      Application.ProcessMessages;
    End;
  End;

  pVerificaAplicaFiltroRegComAlteracao();

  cdsConsulta.EnableControls;
  cdsConsulta.First;

  If rdgOrdernacao.ItemIndex = 0 Then
  Begin
    dbgConsultaDBTableView1Lanc.Visible          := True;
    dbgConsultaDBTableView1Lanc.GroupIndex       :=  0;
    dbgConsultaDBTableView1CTB_CODPOR.GroupIndex := -1;
    dbgConsultaDBTableView1CTB_ARQIMP.GroupIndex := -1;
    dbgConsultaDBTableView1CTB_SEQLAN.Visible    := False;
  End
  Else
  Begin
    dbgConsultaDBTableView1Lanc.Visible          := False;
    dbgConsultaDBTableView1Lanc.GroupIndex       :=  -1;

    dbgConsultaDBTableView1CTB_CODPOR.GroupIndex := 0;
    dbgConsultaDBTableView1CTB_CODPOR.SortIndex  := 0;
    dbgConsultaDBTableView1CTB_CODPOR.SortOrder  := soAscending;

    dbgConsultaDBTableView1CTB_ARQIMP.GroupIndex := 1;
    dbgConsultaDBTableView1CTB_ARQIMP.SortIndex  := 1;
    dbgConsultaDBTableView1CTB_ARQIMP.SortOrder  := soAscending;
    dbgConsultaDBTableView1CTB_SEQLAN.Visible    := True;
  End;

  Result := True;
end;

Procedure TfrmRelCbaLogAcompMovBanNovo.pVerificaAplicaFiltroRegComAlteracao();
 Var
     cmpfiltro : String;
     strListAnteriores : String;
Begin

  If (chkRegComAlteracao.Checked) and (cmbInfRegAlterado.ItemIndex <> -1) Then
  Begin

    cmpfiltro := '';

    Case cmbInfRegAlterado.ItemIndex Of
      0: cmpfiltro := 'CTB_DTALAN';
      1: cmpfiltro := 'CTB_CODPOR';
      2: cmpfiltro := 'CTB_VALLAN';
    End;

    //FILTER PARA PEGAR APENAS AS ALTERACOES CONFORME O COMBO SELECIONADO.
    cdsConsulta.Filtered  := False;
    cdsConsulta.Filter := ' (ALTERACOES LIKE ''%' + cmpfiltro + '%'') ';
    cdsConsulta.Filtered := True;

    strListAnteriores := fRetornaListaRegAntesAlteracao(cdsConsulta);

    If Not FEmptyStr(strListAnteriores) Then
    Begin
       // FILTER PARA TRAZER OS ALTERADOS E O REGISTRO ANTERIOR;
       cdsConsulta.Filtered  := False;
       cdsConsulta.Filter := ' (ALTERACOES LIKE ''%' + cmpfiltro + '%'') '+
                             ' OR (CONTADOR IN (' + strListAnteriores + ') ) ';
       cdsConsulta.Filtered := True;
    End;

  End;

End;

Function TfrmRelCbaLogAcompMovBanNovo.fRetornaListaRegAntesAlteracao(cdsGen:TDataSet): String;
Var
    res : String;
Begin

  res := '';

  cdsGen.First;
  While (Not cdsGen.Eof) Do
  Begin
    res := res + IIf( fEmptyStr(res), Quotedstr(trim(cdsGen.FieldByName('CONT_ANTERIOR').AsString)),
                                      ',' + QuotedStr(trim(cdsGen.FieldByName('CONT_ANTERIOR').AsString)) );

    cdsGen.Next;
  End;

  Result := Res;

End;

procedure TfrmRelCbaLogAcompMovBanNovo.edtCodPortadorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  inherited;
  chrKey := '/';
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    if fPesqPortador(conSimples,
                     Self,
                     edtCodPortador,
                     edtNomPortador,
                     nil,
                     chrKey,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     edtCodEmpresa.Text)  then
    Begin
      If fValidaCampos(edtCodPortador, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  End;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.edtNumSeqExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtNumSeq.Text) Then
  Begin
     mskdtaIni.Clear;
     mskdtaFin.Clear;
  End;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCbaLogAcompMovBanNovo.fAbreConsulta(cxProgress: TcxProgressBar): Boolean;
begin
  Try
    dspConsulta.DataSet := qryConsulta;

    With qryConsulta, Sql Do
    Begin
      Close;
      cdsConsulta.Close;
      Clear;

      Add(fGetSql);

      If Not fSetParametros Then
      Begin
        Result := False;
        Exit;
      End;

      Open;

      If Assigned(dspConsulta.DataSet) Then
        pSetaClient(dspConsulta.DataSet);

      cdsConsulta.Open;

      pSetFilterDefault;

      pMascaraValor;

      pDefineAlteracoes;

      dbgConsultaDBTableView1.DataController.DataSource := dtsConsulta;
      pSetFocus(dbgConsulta);

      Result := RecordCount > 0;
    End;

    blnMudarFoco := FALSE;
  Except

    On E : Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmRelCbaLogAcompMovBanNovo.fAbreConsulta]');
      Result := False;
    End;

  End;
end;

function TfrmRelCbaLogAcompMovBanNovo.fGetSql: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT LOGCBA.*, ';
  strSQL := strSQL + '  REPLACE(IFNULL(CTB_HIST01, ""), "<<csq>>" , " ") AS HIST01, ';
  strSQL := strSQL + '  REPLACE(IFNULL(CTB_HIST02, ""), "<<csq>>" , " ") AS HIST02, ';
  strSQL := strSQL + '  CONCAT(CTB_SEQLAN, "-", CTB_CODEMP) AS LANC, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS ALTERACOES, ';
  strSQL := strSQL + '  "0000" AS CONTADOR, '; //Implementado para sempre gravar o contador, para que possa pegar o anterior qdo usar o filtro do combobox;
  strSQL := strSQL + '  "0000" AS CONT_ANTERIOR '; //Implementado para gravar o nmero referente ao registro anterior;
  strSQL := strSQL + ' FROM LOGCBA    ';
  strSQL := strSQL + ' LEFT JOIN CADOPE ON OPE_CODOPE = CTB_CODOPE ';


  if Not blnVeioMovimentacao then
  begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      If rdgData.ItemIndex = 0 Then //DATA DE LANÇAMENTO
      begin
        strSQL := strSQL + ' WHERE    ';
        strSQL := strSQL + '   CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';
      end
      else
      If rdgData.ItemIndex = 1 Then //DATA DE ALTERAÇÃO
      begin
        strSQL := strSQL + ' WHERE    ';
        strSQL := strSQL + '   CTB_DTALOG BETWEEN :DTAINI AND :DTAFIN ';
      end
      else //DATA DE CONCILIAÇÃO
      begin
        strSQL := strSQL + ' WHERE    ';
        strSQL := strSQL + '   CTB_DTACON BETWEEN :DTAINI AND :DTAFIN ';
      end;
    End
    Else
      strSQL := strSQL + ' WHERE TRUE ';
  end
  else
    strSQL := strSQL + ' WHERE TRUE ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND CTB_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodPortador.Text) Then
    strSQL := strSQL + '  AND CTB_CODPOR = :CODPOR ';

  If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
    strSQL := strSQL + '  AND CTB_CODCTA = :CODCTA ';

  If Not fEmptyStr(edtNumSeq.Text) Then
    strSQL := strSQL + '  AND CTB_SEQLAN = :SEQLAN ';

  If Not fEmptyStr(edtNomeArquivo.Text) Then
    strSQL := strSQL + '   AND CTB_ARQIMP = :ARQUIVOIMPORTACAO ';

  strSQL := strSQL + ' ORDER BY LANC, CTB_DTALOG, CTB_HORLOG ';

  Result := strSQL;

end;

procedure TfrmRelCbaLogAcompMovBanNovo.FormCreate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
  qryConsulta := fCriaQuery(Nil);
end;

procedure TfrmRelCbaLogAcompMovBanNovo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConsulta);
end;

procedure TfrmRelCbaLogAcompMovBanNovo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE:Begin
                If Assigned(cdsConsulta) Then
                Begin
                  If Not cdsConsulta.Active Then
                    Close
                  Else
                   pFechaConsulta;
                End
                Else
                  Close;
              end;
    Else       inherited;
  End;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.FormShow(Sender: TObject);
begin
  inherited;
  intCor    := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  pSetFocus(edtNumSeq);
  edtNumSeq.MaxLength := 13;
  edtNumSeq.TamCampo  := edtNumSeq.MaxLength;
  cmbinfRegAlterado.enabled := False;

  if blnVeioMovimentacao then
  Begin
    pSetFocus(dbgConsulta);
    pnlHeader.Visible := False;
    lblCampoAlterados2.Visible := True;
    Shp_inferior.Visible := True;
  end;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrSel, False) Then
  begin
    if fValidaCampos(fraPlanoDeContas.MskCodCta, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmRelCbaLogAcompMovBanNovo.fSetParametros: Boolean;
begin
  Try
    With qryConsulta Do
    Begin
      if Not blnVeioMovimentacao then
      begin
         If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
         Begin
           ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
           ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
         End;
      end;

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(edtCodPortador.Text) Then
        ParamByName('CODPOR').AsString := edtCodPortador.Text;

      If Not fEmptyStr(edtNumSeq.Text) Then
        ParamByName('SEQLAN').AsString := edtNumSeq.Text;

      If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
        ParamByName('CODCTA').AsString := fraPlanoDeContas.MskCodCta.Text;

      If Not fEmptyStr(edtNomeArquivo.Text) Then
        ParamByName('ARQUIVOIMPORTACAO').AsString := edtNomeArquivo.Text;

    End;

    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelCbaLogAcompMovBanNovo.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And (fEmptyStr(edtNumSeq.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (fEmptyStr(edtNumSeq.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin

            If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
            Begin
              If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
              Begin
                fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
                Result := False;
              End;
            End;

          End;
        End
      End;

    End
    Else If (Sender = edtCodPortador) Then
    Begin

      If fEmptyStr(edtCodPortador.Text) Then
      Begin
        edtNomPortador.Text := 'TODOS';
      End Else
      Begin
        edtNomPortador.Text := fRetNomPortador(edtCodPortador.Text);
        If fEmptyStr(edtNomPortador.Text) Then
        Begin
          Result := False;
          pMensagemOk('Portador Não Encontrado!');
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPortador.Text, edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS';
      End Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          Result := False;
          pMensagemOk('Empresa não encontrada!');
        End

        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fraPlanoDeContas.edtDesCta.Text := 'TODOS';
      End Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(fraPlanoDeContas.MskCodCta.Text);
        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          Result := False;
          pMensagemOk('Plano de Contas Não Encontrado!');
        End;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelCbaLogAcompMovBanNovo.pDefineAlteracoes;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := True;
    frmGravando.blnDesabilitaMouse  := True;
    frmGravando.lblGravando.Caption := 'Verificando Alterações...';
    frmGravando.fExecutarAcao       := DefineAlteracoes;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaCxGridNova.pAjustaColunas]');
    End;
  End;

  pFreeAndNil(frmGravando);
end;

procedure TfrmRelCbaLogAcompMovBanNovo.pFechaConsulta;
begin
  cdsConsulta.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodPortador.Clear;
  edtNomPortador.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtNumSeq.Clear;
  fraPlanoDeContas.MskCodCta.Clear;

  pSetFocus(edtNumSeq);
end;

procedure TfrmRelCbaLogAcompMovBanNovo.pMascaraValor;
  Var
    intIndex: integer;
begin
  If cdsConsulta.Active Then
    With cdsConsulta Do
    For intIndex := 1 To Fields.Count - 1 Do
      Case Fields[intIndex].DataType Of
        ftFloat: TFloatField(Fields[intIndex]).DisplayFormat := fMskDigitos(2); //'#0.00';
        ftDate : TFloatField(Fields[intIndex]).EditMask      := '99/99/9999;1;_';
      End;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.pSetFilterDefault;
begin
  cdsConsulta.Filter := '';
  If cdsConsulta.Filtered Then
    cdsConsulta.Filtered := FALSE;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.StepStatusSelecao(
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmRelCbaLogAcompMovBanNovo.fCarregaCampos(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Application.ProcessMessages;
  //dbgConsultaDBTableView1.ApplyBestFit();
  //Application.ProcessMessages;
  fAbreConsulta;
  MouseShowCursor(True);
  Application.ProcessMessages;
  pSetFocus(dbgConsulta);
  Result := True;
end;

procedure TfrmRelCbaLogAcompMovBanNovo.pCarregaCampos;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.blnDesabilitaMouse  := True;
    frmGravando.lblGravando.Caption := 'Carregando Campos...';
    frmGravando.fExecutarAcao := fCarregaCampos;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRelCbaLogAcompMovBanNovo.pCarregaCampos]');
  End;
  pFreeAndNil(frmGravando);
end;


function TfrmRelCbaLogAcompMovBanNovo.MouseShowCursor(const Show: boolean): boolean;
var
  I: integer;
begin
  I := ShowCursor(LongBool(true));
  if Show then
  begin
    Result := I >= 0;
    while I < 0 do begin
      Result := ShowCursor(LongBool(true)) >= 0;
      Inc(I);
    end;
  end
  else
  begin
    Result := I < 0;
    while I >= 0 do
    begin
      Result := ShowCursor(LongBool(false)) < 0;
      Dec(I);
    end;
  end;
end;


end.
