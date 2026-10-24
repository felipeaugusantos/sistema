unit untCadTipoImobilizado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiCadContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, EditFocus;

type
  TfrmTipoImobilizado = class(TfrmPaiCadContabilidade)
    pnlContainer: TPanel;
    dbeCodTip: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dbeAlqDep: TDBEditFocus;
    lblTaxDep: TLabel;
    dtsDados: TDataSource;
    gbAtivoImobilizado: TGroupBox;
    dbePCATIM: TDBEditFocus;
    edtPCATIM: TEditFocus;
    gbFiscal: TGroupBox;
    Label3: TLabel;
    dbeVDUTFI: TDBEditFocus;
    GroupBox1: TGroupBox;
    edtPCDAFI: TEditFocus;
    dbePCDAFI: TDBEditFocus;
    GroupBox2: TGroupBox;
    edtPCDDFI: TEditFocus;
    dbePCDDFI: TDBEditFocus;
    gbSocietaria: TGroupBox;
    Label4: TLabel;
    dbeVDUTSO: TDBEditFocus;
    GroupBox4: TGroupBox;
    edtPCDASO: TEditFocus;
    dbePCDASO: TDBEditFocus;
    GroupBox5: TGroupBox;
    edtPCDDSO: TEditFocus;
    dbePCDDSO: TDBEditFocus;
    gbCorrecaoMonetaria: TGroupBox;
    dbePCCRMN: TDBEditFocus;
    edtPCCRMN: TEditFocus;
    gbAvaliacao: TGroupBox;
    dbePCAJPT: TDBEditFocus;
    edtPCAJPT: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbePCATIMKeyPress(Sender: TObject; var Key: Char);
    procedure dbePCDAFIKeyPress(Sender: TObject; var Key: Char);
    procedure dbePCDASOKeyPress(Sender: TObject; var Key: Char);
    procedure dbePCDDSOKeyPress(Sender: TObject; var Key: Char);
    procedure dbePCCRMNKeyPress(Sender: TObject; var Key: Char);
    procedure dbePCAJPTKeyPress(Sender: TObject; var Key: Char);
    procedure dbePCDDFIKeyPress(Sender: TObject; var Key: Char);
    procedure dbePCATIMExit(Sender: TObject);
    procedure dbePCDAFIExit(Sender: TObject);
    procedure dbePCDDFIExit(Sender: TObject);
    procedure dbePCDASOExit(Sender: TObject);
    procedure dbePCDDSOExit(Sender: TObject);
    procedure dbePCCRMNExit(Sender: TObject);
    procedure dbePCAJPTExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    blnExisteCampoNCO_NATURE : boolean;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregaDados;
    procedure pAjustaComponentesVisuais;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  TypesRel, untTypesSistema, untFuncoesSimples, Contabilidade.Consultas, Contabilidade.Funcoes;

{$R *.dfm}

procedure TfrmTipoImobilizado.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDados ;
end;

procedure TfrmTipoImobilizado.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaDados ;
end;

procedure TfrmTipoImobilizado.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodTip, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodTip, dbeCodTip, True);

  dbeAlqDep.Text := '0,00';
  pCarregaDados ;
end;

procedure TfrmTipoImobilizado.btnPesquisaClick(Sender: TObject);
var
  chrKey         : Char;
  arrTimpImo     : TConsultasArray;
begin
  chrKey := '/';
  fPesqTipoImobilizado(Self, Nil, Nil, qryTabela, chrKey, arrTimpImo);
  pCarregaDados ;
end;

procedure TfrmTipoImobilizado.dbePCAJPTExit(Sender: TObject);
begin
  inherited;
  edtPCAJPT.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCAJPT.Text)], False);
end;

procedure TfrmTipoImobilizado.dbePCAJPTKeyPress(Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('TIP_PCAJPT')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbePCAJPT, edtPCAJPT, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtPCAJPT.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCAJPT.Text)]);
    Finally
      TStringField(qryTabela.FieldByName('TIP_PCAJPT')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmTipoImobilizado.dbePCATIMExit(Sender: TObject);
begin
  inherited;
  edtPCATIM.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCATIM.Text)], False);
end;

procedure TfrmTipoImobilizado.dbePCATIMKeyPress(Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('TIP_PCATIM')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbePCATIM, edtPCATIM, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtPCATIM.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCATIM.Text)]);
    Finally
      TStringField(qryTabela.FieldByName('TIP_PCATIM')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmTipoImobilizado.dbePCCRMNExit(Sender: TObject);
begin
  inherited;
  edtPCCRMN.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCCRMN.Text)], False);
end;

procedure TfrmTipoImobilizado.dbePCCRMNKeyPress(Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('TIP_PCCRMN')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbePCCRMN, edtPCCRMN, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtPCCRMN.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCCRMN.Text)]);
    Finally
      TStringField(qryTabela.FieldByName('TIP_PCCRMN')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmTipoImobilizado.dbePCDAFIExit(Sender: TObject);
begin
  inherited;
  edtPCDAFI.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDAFI.Text)], False);
end;

procedure TfrmTipoImobilizado.dbePCDAFIKeyPress(Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('TIP_PCDAFI')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbePCDAFI, edtPCDAFI, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtPCDAFI.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDAFI.Text)]);
    Finally
      TStringField(qryTabela.FieldByName('TIP_PCDAFI')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmTipoImobilizado.dbePCDASOExit(Sender: TObject);
begin
  inherited;
  edtPCDASO.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDASO.Text)], False);
end;

procedure TfrmTipoImobilizado.dbePCDASOKeyPress(Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('TIP_PCDASO')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbePCDASO, edtPCDASO, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtPCDASO.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDASO.Text)]);
    Finally
      TStringField(qryTabela.FieldByName('TIP_PCDASO')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmTipoImobilizado.dbePCDDFIExit(Sender: TObject);
begin
  inherited;
  edtPCDDFI.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDDFI.Text)], False);
end;

procedure TfrmTipoImobilizado.dbePCDDFIKeyPress(Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('TIP_PCDDFI')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbePCDDFI, edtPCDDFI, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtPCDDFI.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDDFI.Text)]);
    Finally
      TStringField(qryTabela.FieldByName('TIP_PCDDFI')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmTipoImobilizado.dbePCDDSOExit(Sender: TObject);
begin
  inherited;
  edtPCDDSO.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDDSO.Text)], False);
end;

procedure TfrmTipoImobilizado.dbePCDDSOKeyPress(Sender: TObject; var Key: Char);
Var
  arrPlan: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    TStringField(qryTabela.FieldByName('TIP_PCDDSO')).EditMask := '';
    Try
      If fPesqPlanoContabil(Self, dbePCDDSO, edtPCDDSO, Nil, Key, arrPlan, True, '', not blnExisteCampoNCO_NATURE) Then
        SelectNext(ActiveControl, True, True);

      edtPCDDSO.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDDSO.Text)]);
    Finally
      TStringField(qryTabela.FieldByName('TIP_PCDDSO')).EditMask := fMskCon;
    End;
  End;
end;

procedure TfrmTipoImobilizado.FormCreate(Sender: TObject);
begin
  inherited;
  blnExisteCampoNCO_NATURE := fCampoExiste('PLANCO', 'NCO_NATURE');
  pAjustaComponentesVisuais ;
  strNomeTabela        := 'TIPIMO';
  strNomeCampo         := 'TIP_CODTIP';
  qryTabela            := fCriaQuery(Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsDados.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodTip
end;

procedure TfrmTipoImobilizado.FormShow(Sender: TObject);
begin
  inherited;
  TFloatField(qryTabela.FieldByName('TIP_ALQDEP') As TFloatField).DisplayFormat := '#0.00';
end;

function TfrmTipoImobilizado.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
 Result := True;
 If Sender = dbeAlqDep Then
 Begin
   If fEmptyStr(dbeAlqDep.Text) Then
     dbeAlqDep.Text := '0,00'
   Else If StrToFloat(dbeAlqDep.Text) < 0 Then
   Begin
     pMensagemOk('O Campo Taxa de depreciação anual deve ser maior ou igual a zero!');
     Result := False;
   End;
 End
end;

procedure TfrmTipoImobilizado.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TIP_CODTIP');
  stlCampos.Add('TIP_DESCRI');

  stlCamInd.Add('TIP_CODTIP');
  stlCamInd.Add('TIP_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');

  if fTemPlancosTipoImobilizado then
  begin
    stlCampos.Add('TIP_PCATIM');
    stlCampos.Add('TIP_VDUTFI');
    stlCampos.Add('TIP_PCDAFI');
    stlCampos.Add('TIP_PCDDFI');
    stlCampos.Add('TIP_VDUTSO');
    stlCampos.Add('TIP_PCDASO');
    stlCampos.Add('TIP_PCDDSO');
    stlCampos.Add('TIP_PCCRMN');
    stlCampos.Add('TIP_PCAJPT');

    stlCamInd.Add('TIP_PCATIM');
    stlCamInd.Add('TIP_VDUTFI');
    stlCamInd.Add('TIP_PCDAFI');
    stlCamInd.Add('TIP_PCDDFI');
    stlCamInd.Add('TIP_VDUTSO');
    stlCamInd.Add('TIP_PCDASO');
    stlCamInd.Add('TIP_PCDDSO');
    stlCamInd.Add('TIP_PCCRMN');
    stlCamInd.Add('TIP_PCAJPT');

    stlDesInd.Add('Ativo Imobilizado');
    stlDesInd.Add('Vida Útil - Depreciação (Anos) - Fiscal');
    stlDesInd.Add('Depreciação Acumulada - Fiscal');
    stlDesInd.Add('Despesa com Depreciação - Fiscal');
    stlDesInd.Add('Vida Útil - Depreciação (Anos) - Societária');
    stlDesInd.Add('Depreciação Acumulada - Societária');
    stlDesInd.Add('Despesa com Depreciação - Societária');
    stlDesInd.Add('Correção Monetária');
    stlDesInd.Add('Ajuste Avaliação Patrimonial');
  end;
  stlCampos.Add('AUTOINCREM');

end;

procedure TfrmTipoImobilizado.pAfterOpen(DataSet: TDataSet);
begin
  If DataSet.FindField('TIP_PCATIM') <> nil Then
    TStringField(DataSet.FieldByName('TIP_PCATIM')).EditMask := fMskCon;

  If DataSet.FindField('TIP_PCDAFI') <> nil Then
    TStringField(DataSet.FieldByName('TIP_PCDAFI')).EditMask := fMskCon;

  If DataSet.FindField('TIP_PCDDFI') <> nil Then
    TStringField(DataSet.FieldByName('TIP_PCDDFI')).EditMask := fMskCon;

  If DataSet.FindField('TIP_PCDASO') <> nil Then
    TStringField(DataSet.FieldByName('TIP_PCDASO')).EditMask := fMskCon;

  If DataSet.FindField('TIP_PCDDSO') <> nil Then
    TStringField(DataSet.FieldByName('TIP_PCDDSO')).EditMask := fMskCon;

  If DataSet.FindField('TIP_PCCRMN') <> nil Then
    TStringField(DataSet.FieldByName('TIP_PCCRMN')).EditMask := fMskCon;

  If DataSet.FindField('TIP_PCAJPT') <> nil Then
    TStringField(DataSet.FieldByName('TIP_PCAJPT')).EditMask := fMskCon;
end;

procedure TfrmTipoImobilizado.pAjustaComponentesVisuais;
var
  intCfgDepImo: Integer;
  blnExistePlanoContas: boolean;
  intAjusteTop: Integer;
begin
  intCfgDepImo := fCfgSis('DEPIMO', varInteger);
  dbeAlqDep.Visible := intCfgDepImo > 1;
  lblTaxDep.Visible := dbeAlqDep.Visible;

  blnExistePlanoContas := fTemPlancosTipoImobilizado ;

  intAjusteTop := 0 ;
  if not dbeAlqDep.Visible then
  begin
    intAjusteTop := gbAtivoImobilizado.Top - lblTaxDep.Top ;
    ////ajusta o tamanho do formulario
    self.Height := self.Height - intAjusteTop ;
  end;

  gbAtivoImobilizado.Top := gbAtivoImobilizado.Top - intAjusteTop ;
  gbFiscal.Top := gbFiscal.Top - intAjusteTop ;
  gbSocietaria.Top := gbSocietaria.Top - intAjusteTop ;
  gbCorrecaoMonetaria.Top := gbCorrecaoMonetaria.Top - intAjusteTop ;
  gbAvaliacao.Top := gbAvaliacao.Top - intAjusteTop ;

  if not blnExistePlanoContas then
  begin
    gbAtivoImobilizado.Visible := False ;
    gbFiscal.Visible := False ;
    gbSocietaria.Visible := False ;
    gbCorrecaoMonetaria.Visible := False ;
    gbAvaliacao.Visible := False ;
    ////desvincula os Fields
    dbePCATIM.DataField := '' ;
    dbeVDUTFI.DataField := '' ;
    dbePCDAFI.DataField := '' ;
    dbePCDDFI.DataField := '' ;
    dbeVDUTSO.DataField := '' ;
    dbePCDASO.DataField := '' ;
    dbePCDDSO.DataField := '' ;
    dbePCCRMN.DataField := '' ;
    dbePCAJPT.DataField := '' ;
    ////ajusta o tamanho do formulario
    self.Height := self.Height - ((gbAvaliacao.Top+gbAvaliacao.Height)-gbAtivoImobilizado.Top) ;
  end;

end;

procedure TfrmTipoImobilizado.pCarregaDados;
begin
  if not fTemPlancosTipoImobilizado then
  begin
    exit ;
  end;

  edtPCAJPT.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCAJPT.Text)], False);
  edtPCATIM.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCATIM.Text)], False);
  edtPCCRMN.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCCRMN.Text)], False);
  edtPCDAFI.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDAFI.Text)], False);
  edtPCDASO.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDASO.Text)], False);
  edtPCDDFI.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDDFI.Text)], False);
  edtPCDDSO.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [fSemMascaraPlaNco(dbePCDDSO.Text)], False);

end;

end.
