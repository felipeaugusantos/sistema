unit untPreenchimentoAutomatizadoAbreviacaoICMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, QColorLabel, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade,
  Vcl.CheckLst, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons,
  cxControls, cxContainer, cxEdit, cxCustomListBox, cxCheckListBox,
  System.Generics.Collections, untTValidaExcel,ComObj, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, UniClientDataSet;

type
  TfrmPreenchimentoAutomatizadoAbreviacaoICMS = class(TfrmPai)
    btnRealizarPreenchimento: TBitBtnLocked;
    pnlCentral: TPanel;
    pnlDadosAbrev: TPanel;
    gpbPerfis: TGroupBox;
    chkPerfis: TCheckListBox;
    pnlDados: TPanel;
    Shape1: TShape;
    Label4: TLabel;
    grp3: TGroupBox;
    lbl1: TLabel;
    Label2: TLabel;
    edtCodSitDentro: TEditFocus;
    edtDesSitDentro: TEditFocus;
    edtCodSitFora: TEditFocus;
    edtDesSitFora: TEditFocus;
    grpMensagens: TGroupBox;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    grpDifal: TGroupBox;
    Label3: TLabel;
    lblMatrizBasesDifal: TLabel;
    edtAlqEfO: TEditFocus;
    edtCodMatBasDif: TEditFocus;
    edtDesMatBasDif: TEditFocus;
    grpST: TGroupBox;
    lbl4: TLabel;
    lbl6: TLabel;
    edtIVAOri: TEditFocus;
    edtBasRet: TEditFocus;
    grpEntrada: TGroupBox;
    lbl3: TLabel;
    Label1: TLabel;
    edtBasIcm: TEditFocus;
    edtMatIcm: TEditFocus;
    edtDesMatIcm: TEditFocus;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    edtMatFcp: TEditFocus;
    edtDesMatFcp: TEditFocus;
    chkZerarParaCstStDentroEstado: TCheckBox;
    gpbUfs: TGroupBox;
    chkUfs: TCheckListBox;
    pnlUfs: TPanel;
    btnMarcarTodasUf: TBitBtnLocked;
    btnImportarArquivo: TBitBtnLocked;
    btnModeloArquivoImportar: TBitBtnLocked;
    frxHelp: TfrxReport;
    grpCodBen: TGroupBox;
    edtCodBen: TEditFocus;
    procedure btnRealizarPreenchimentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodSitDentroKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSitDentroExit(Sender: TObject);
    procedure cmbTipoCalculoSTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure edtMatIcmKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure chkPerfisKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMatFcpKeyPress(Sender: TObject; var Key: Char);
    procedure chkPerfisClick(Sender: TObject);
    procedure edtCodMatBasDifKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodasUfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnModeloArquivoImportarClick(Sender: TObject);
    procedure btnImportarArquivoClick(Sender: TObject);
  private
    { Private declarations }
    qryConTri: TUniQuery;

    objValidaExcel: TValidadorExcel;

    blnArqCsv: Boolean;

    const
      cPERFIL = 'A';
      cUF = 'B';
      cCST = 'C';
      cBASEICMS = 'D';
      cALIQUOTAICMS = 'E';
      cBASEST = 'F';
      cALIQINTERNAST = 'G';
      cALIQREDUZIDAST = 'H';
      cIVAST = 'I';
      cALIQEFETIVAORIGEMDIFAL = 'J';
      cALIQINTERNAESTADODESTINODIFAL = 'K';
      cBASEDESTINODIFAL = 'L';
      cFCP = 'M';
      cCODBEN = 'N';
      cQtdColunas = 14;

     const
      cDescPERFIL = 'PERFIL';
      cDescUF = 'UF';
      cDescCST = 'CST';
      cDescBASEICMS = '% BASE ICMS';
      cDescALIQUOTAICMS = '% ALIQUOTA ICMS';
      cDescBASEST = '% BASE ST';
      cDescALIQINTERNAST = '% ALIQ INTERNA ST';
      cDescALIQREDUZIDAST = '% ALIQ REDUZIDA ST';
      cDescIVAST = 'IVA ST';
      cDescALIQEFETIVAORIGEMDIFAL = '% ALIQ EFETIVA ORIGEM – DIFAL';
      cDescALIQINTERNAESTADODESTINODIFAL = '% ALIQ INTERNA ESTADO DESTINO – DIFAL';
      cDescBASEDESTINODIFAL = '% BASE DESTINO – DIFAL';
      cDescFCP = '% FCP';
      cDescCODBEN = 'CÓDIGO BENEFÍCIO FISCAL';

    procedure pCarregaSitTri;
    function fSelecionouPerfil: Boolean;
    function fEditandoPerfilDeEntrada: Boolean;
    function fSelecionouUF: Boolean;
    procedure pMarcarTodosUF(blnMarcar: Boolean);
    procedure pPrepararPlanilha;
    procedure pCriarDataSet;
    procedure pInserirItemDataSet(intLinha: integer);
    function fConvetVazioToNull(texto: string): Variant;
    function fTemTitulo: boolean;
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    cdsAbreviacoesPlanilha: TUniClientDataSet;
  end;

implementation

uses untFuncoesSimples, untPesqAux, untConsultas, StrUtils,
  untTypesSistema, untConstantes;

{$R *.dfm}
{ TfrmPreenchimentoAutomatizadoAbreviacaoICMS }

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.pCarregaSitTri;
begin
  pPesquisaCadTri(qryConTri, qryConTri, edtCodSitDentro.Text);
  edtDesSitDentro.Text := qryConTri.FieldByName('TRI_DESC01').AsString;

  pPesquisaCadTri(qryConTri, qryConTri, edtCodSitFora.Text);
  edtDesSitFora.Text := qryConTri.FieldByName('TRI_DESC01').AsString;
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.pMarcarTodosUF(
  blnMarcar: Boolean);
Var
  intIndex: Integer;
begin
  For intIndex := 0 To chkUfs.Items.Count - 1 Do
    chkUfs.Checked[intIndex] := blnMarcar;

  if blnMarcar then
    btnMarcarTodasUf.Caption := 'Desmarcar todas'
  else
    btnMarcarTodasUf.Caption := 'Marcar todas';
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.pCriarDataSet;
begin
  If Assigned(cdsAbreviacoesPlanilha) Then
    FreeAndNil(cdsAbreviacoesPlanilha);

  cdsAbreviacoesPlanilha := TUniClientDataSet.Create(Self);

  cdsAbreviacoesPlanilha.FieldDefs.Add('PERFIL', ftString, 3);
  cdsAbreviacoesPlanilha.FieldDefs.Add('UF', ftString, 2);
  cdsAbreviacoesPlanilha.FieldDefs.Add('CST', ftString, 3);
  cdsAbreviacoesPlanilha.FieldDefs.Add('BASEICMS', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('ALIQUOTAICMS', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('BASEST', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('ALIQINTERNAST', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('ALIQREDUZIDAST', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('IVAST', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('ALIQEFETIVAORIGEMDIFAL', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('ALIQINTERNAESTADODESTINODIFAL', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('BASEDESTINODIFAL', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('FCP', ftFloat);
  cdsAbreviacoesPlanilha.FieldDefs.Add('CODBEN', ftString, 10);

  cdsAbreviacoesPlanilha.CreateDataSet;
  cdsAbreviacoesPlanilha.Open
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.pInserirItemDataSet(
  intLinha: integer);
begin
  cdsAbreviacoesPlanilha.Append;

  cdsAbreviacoesPlanilha.FieldByName('PERFIL').Value := UpperCase(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPERFIL)));
  cdsAbreviacoesPlanilha.FieldByName('UF').Value := UpperCase(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cUF)));
  cdsAbreviacoesPlanilha.FieldByName('CST').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCST));
  cdsAbreviacoesPlanilha.FieldByName('BASEICMS').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cBASEICMS));
  cdsAbreviacoesPlanilha.FieldByName('ALIQUOTAICMS').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cALIQUOTAICMS));
  cdsAbreviacoesPlanilha.FieldByName('BASEST').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cBASEST));
  cdsAbreviacoesPlanilha.FieldByName('ALIQINTERNAST').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cALIQINTERNAST));
  cdsAbreviacoesPlanilha.FieldByName('ALIQREDUZIDAST').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cALIQREDUZIDAST));
  cdsAbreviacoesPlanilha.FieldByName('IVAST').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cIVAST));
  cdsAbreviacoesPlanilha.FieldByName('ALIQEFETIVAORIGEMDIFAL').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cALIQEFETIVAORIGEMDIFAL));
  cdsAbreviacoesPlanilha.FieldByName('ALIQINTERNAESTADODESTINODIFAL').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cALIQINTERNAESTADODESTINODIFAL));
  cdsAbreviacoesPlanilha.FieldByName('BASEDESTINODIFAL').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cBASEDESTINODIFAL));
  cdsAbreviacoesPlanilha.FieldByName('FCP').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cFCP));
  cdsAbreviacoesPlanilha.FieldByName('CODBEN').Value := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODBEN));

  cdsAbreviacoesPlanilha.Post;
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.pPrepararPlanilha;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescPERFIL, cPERFIL, 3, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescUF, cUF, 2, True, True, '', ''));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescCST, cCST, 3, True, False, '', '', True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescBASEICMS, cBASEICMS));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescALIQUOTAICMS, cALIQUOTAICMS));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescBASEST, cBASEST));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescALIQINTERNAST, cALIQINTERNAST));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescALIQREDUZIDAST, cALIQREDUZIDAST));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescIVAST, cIVAST));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescALIQEFETIVAORIGEMDIFAL, cALIQEFETIVAORIGEMDIFAL));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescBASEDESTINODIFAL, cBASEDESTINODIFAL));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDescFCP, cFCP));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDescCODBEN, cCODBEN, 10, True, False, '', '', True));
end;

function TfrmPreenchimentoAutomatizadoAbreviacaoICMS.fValidaCampos
  (Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtCodSitDentro) Then
  Begin
    If fEmptyStr(edtCodSitDentro.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A Situação Tributaria (CST) deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaSitTri;
      If fEmptyStr(edtDesSitDentro.Text) Then
      Begin
        fMensagem('ATENÇÃO!',
          'Essa Situação Tributaria não está cadastrada!', ['&Ok']);
        Result := False;
      End
      Else
        blnMudarFoco := True;
    End;
  End
  Else If (Sender = edtCodSitFora) Then
  Begin
    If fEmptyStr(edtCodSitFora.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A Situação Tributaria (CST) deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaSitTri;
      If fEmptyStr(edtDesSitFora.Text) Then
      Begin
        fMensagem('ATENÇÃO!',
          'Essa Situação Tributaria não está cadastrada!', ['&Ok']);
        Result := False;
      End
      Else
        blnMudarFoco := True;
    End;
  End
  Else If (Sender = edtMatIcm) Then
  Begin
    edtDesMatIcm.Text := fRetDescricaoMatrizAliquotasIcms(edtMatIcm.Text);
    If fEmptyStr(edtMatIcm.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A matriz de alíquota de ICMS deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(edtDesMatIcm.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'Essa matriz de alíquota de ICMS não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtMatFcp) Then
  Begin
    edtDesMatFcp.Text := fRetDescricaoMatrizAliquotasFcp(edtMatFcp.Text);
    If fEmptyStr(edtMatFcp.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'A matriz de alíquota de FCP deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(edtDesMatFcp.Text) Then
    Begin
      fMensagem('ATENÇÃO!',
        'Essa matriz de alíquota de FCP não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtBasIcm) Or (Sender = edtBasRet) Then
  Begin
    If fEmptyStr((Sender As TEditFocus).Text) Then
    Begin
      (Sender As TEditFocus).Text := '0';
    End
    Else If (fStrToFloat((Sender As TEditFocus).Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!',
        'O percentual da Base deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtCodMatBasDif) And edtCodMatBasDif.Visible Then
  Begin
    edtDesMatBasDif.Text := fRetDescricaoMatrizBasesDoDifal(edtCodMatBasDif.Text);
    If fEmptyStr(edtCodMatBasDif.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Matriz Bases do Difal deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If fEmptyStr(edtDesMatBasDif.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa Matriz Bases do Difal não está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtAlqEfO) Then
  Begin
    If fEmptyStr((Sender As TEditFocus).Text) Then
    Begin
      (Sender As TEditFocus).Text := '0';
    End
    Else If (fStrToFloat((Sender As TEditFocus).Text) < 0) Or
      (fStrToFloat((Sender As TEditFocus).Text) > 100) Then
    Begin
      fMensagem('ATENÇÃO!', 'Percentual de aliquota inválido!', ['&Ok']);
      Result := False;
    End;
  End
  Else If (Sender = edtIVAOri) Then
  Begin
    If fEmptyStr((Sender As TEditFocus).Text) Then
    Begin
      (Sender As TEditFocus).Text := '0';
    End
    Else If (fStrToFloat((Sender As TEditFocus).Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'IVA original não pode ser negativo!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.chkPerfisClick(
  Sender: TObject);
begin
  inherited;
  btnRealizarPreenchimento.Enabled := fSelecionouPerfil;
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.chkPerfisKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  btnRealizarPreenchimento.Enabled := fSelecionouPerfil;
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.cmbTipoCalculoSTKeyDown
  (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.edtMatFcpKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqMatrizAliquotasFcp(Self, edtMatFcp, edtDesMatFcp, nil, Key, arrSel) Then
    If fValidaCampos(TEditFocus(Sender)) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.edtMatIcmKeyPress
  (Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqMatrizAliquotasIcms(Self, edtMatIcm, edtDesMatIcm, nil, Key, arrSel) Then
    If fValidaCampos(TEditFocus(Sender)) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmPreenchimentoAutomatizadoAbreviacaoICMS.fConvetVazioToNull(
  texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

function TfrmPreenchimentoAutomatizadoAbreviacaoICMS.fEditandoPerfilDeEntrada: Boolean;
begin
  If chkPerfis.ItemIndex = -1 Then
    Exit(False);

  If chkPerfis.Items[chkPerfis.ItemIndex].StartsWith('PEF') Then
    Exit(True);

  If chkPerfis.Items[chkPerfis.ItemIndex].StartsWith('PEJ') Then
    Exit(True);

  If chkPerfis.Items[chkPerfis.ItemIndex].StartsWith('PER') Then
    Exit(True);

  If chkPerfis.Items[chkPerfis.ItemIndex].StartsWith('PES') Then
    Exit(True);
  If chkPerfis.Items[chkPerfis.ItemIndex].StartsWith('PSI') Then
    Exit(True);

  If chkPerfis.Items[chkPerfis.ItemIndex].StartsWith('PII') Then
    Exit(True);

  Result := False;
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.edtCodMatBasDifKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqMatrizBasesDifal(Self, edtCodMatBasDif, edtDesMatBasDif, nil, Key, arrSel) Then
    If fValidaCampos(TEditFocus(Sender)) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.edtCodSitDentroExit
  (Sender: TObject);
begin
  inherited;
  If (Pos(edtCodSitDentro.Text, CST_SUBSTITUICAO + '_' + CST_ANTECIPACAO_ICMS) <= 0)
    And (Pos(edtCodSitFora.Text, CST_SUBSTITUICAO + '_' + CST_ANTECIPACAO_ICMS) <= 0) Then
  Begin
    edtBasRet.Text := '0,000';
    edtIVAOri.Text := '0,00';
    grpST.Enabled := False;
  End
  Else
    grpST.Enabled := True;

  chkZerarParaCstStDentroEstado.Enabled := (Not fEditandoPerfilDeEntrada) And
   (Pos(edtCodSitDentro.Text, CST_SUBSTITUICAO) > 0);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.edtCodSitDentroKeyPress
  (Sender: TObject; var Key: Char);
Var
  arrSitTrib: TConsultasArray;
begin
  inherited;
  If fPesqSitTributaria(Self, TEditFocus(Sender), Nil, Nil, Key, arrSitTrib) And
    fValidaCampos(TEditFocus(Sender)) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.FormActivate
  (Sender: TObject);
begin
  inherited;
  pSetFocus(chkPerfis);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.FormCreate(
  Sender: TObject);
begin
  inherited;

  pMarcarTodosUF(True);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.FormDestroy
  (Sender: TObject);
begin
  inherited;
  If Assigned(qryConTri) Then
    FreeAndNil(qryConTri);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.btnMarcarTodasUfClick(
  Sender: TObject);
Var
  blnMarcar: Boolean;
begin
  blnMarcar := btnMarcarTodasUf.Caption = 'Marcar todas';

  pMarcarTodosUF(blnMarcar);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.btnImportarArquivoClick(
  Sender: TObject);
var
  dlgOpen: TOpenDialog;
  intContador, intValIni: Integer;
begin
  dlgOpen := TOpenDialog.Create(Self);
  dlgOpen.Filter := 'Arquivos do Excel|*.xls;*.xlsx;*.csv';

  if dlgOpen.Execute then
  begin
    If Not (FileExists(dlgOpen.FileName)) Then
    Begin
      pMensagemOk('Arquivo não encontrado : ' + dlgOpen.FileName + ' !');
      Exit;
    End;

    objValidaExcel := TValidadorExcel.Create(dlgOpen.FileName, cQtdColunas, '', '', 0);
    pPrepararPlanilha;
    pCriarDataSet;
    blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';

    intValIni := IIf(fTemTitulo, 1 , 0);

    For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
    Begin
      If blnArqCsv Then
        If intContador > objValidaExcel.ArquivoCSV.Count Then
          Continue;

      pInserirItemDataSet(intContador);
    End;

    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.btnModeloArquivoImportarClick(
  Sender: TObject);
begin
  inherited;

  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.
  btnRealizarPreenchimentoClick(Sender: TObject);
begin
  inherited;
  If Not fSelecionouPerfil Then
  Begin
    pMensagemOk('Nenhum perfil foi selecionado para preenchimento automatizado!');
    Exit;
  End;

  If Not fSelecionouUF Then
  Begin
    pMensagemOk('Nenhuma UF foi selecionada para preenchimento automatizado!');
    Exit;
  End;

  If Not fSelecionouUF Then
  Begin
    pMensagemOk('Nenhuma UF foi selecionada para preenchimento automatizado!');
    Exit;
  End;

  If Not btnRealizarPreenchimento.Enabled Then
    Exit;

  If fVerificaCampos Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

function TfrmPreenchimentoAutomatizadoAbreviacaoICMS.fSelecionouPerfil: Boolean;
Var
  intIndex: Integer;
begin
  Result := False;
  For intIndex := 0 To chkPerfis.Items.Count - 1 Do
    If chkPerfis.Checked[intIndex] Then
      Exit(True);
end;

function TfrmPreenchimentoAutomatizadoAbreviacaoICMS.fSelecionouUF: Boolean;
Var
  intIndex: Integer;
begin
  Result := False;
  For intIndex := 0 To chkUfs.Items.Count - 1 Do
    If chkUfs.Checked[intIndex] Then
      Exit(True);
end;

function TfrmPreenchimentoAutomatizadoAbreviacaoICMS.fTemTitulo: boolean;
begin
 If objValidaExcel.fGetValueCSV(0, cPERFIL) <> '' Then
      Result := (Pos(Trim(objValidaExcel.fGetValueCSV(0, cPERFIL)), 'PEF_PEJ_PER_PSI_PII_PES_CNC_SNA_IND_TRS_NCO_CCO_CTA_PRU') <= 0)
    Else
      Result := False;
end;

procedure TfrmPreenchimentoAutomatizadoAbreviacaoICMS.FormShow(Sender: TObject);
begin
  inherited;
  If Not Assigned(qryConTri) Then
    qryConTri := fCriarQuery('SELECT * FROM CADTRI WHERE FALSE');

  If Not fCfgSis('BASDFL', varBoolean) Then
  Begin
    lblMatrizBasesDifal.Visible := False;
    edtCodMatBasDif.Visible     := False;
    edtDesMatBasDif.Visible     := False;
  End;

  chkPerfis.OnKeyDown := pOnKeyDown;
  btnRealizarPreenchimento.Enabled := fSelecionouPerfil;
  grpCodBen.Visible := fCfgSis('OBRBEN', varBoolean);
end;

end.
