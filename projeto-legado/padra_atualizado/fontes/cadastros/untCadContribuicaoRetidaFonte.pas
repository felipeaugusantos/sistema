unit untCadContribuicaoRetidaFonte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel, EditFocus, Uni, StrUtils, UniClientDataSet,
  DBLookupComboBoxFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, untDBECgcCpf, ComboBoxFocus,
  cxTextEdit, cxMaskEdit, cxDBEdit;

type
  TfrmCadContribuicaoRetidaFonte = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlGeral: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label15: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dtsIndNre: TDataSource;
    dtsIndNRF: TDataSource;
    dtsIndCpj: TDataSource;
    dbeIndNre: TDBLookupComboBoxFocus;
    dbeIndNRF: TDBLookupComboBoxFocus;
    dbeIndCpj: TDBLookupComboBoxFocus;
    dbeBasRet: TDBEditFocus;
    dbeValRet: TDBEditFocus;
    dbeValRep: TDBEditFocus;
    dbeValRec: TDBEditFocus;
    dbeDtaRet: TDBEditFocus;
    dbeCodRec: TDBEditFocus;
    dbeCnpjFP: TDBEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    cdsIndNre: TUniClientDataSet;
    cdsIndNRF: TUniClientDataSet;
    cdsIndCpj: TUniClientDataSet;
    procedure pCriaIndNre();
    procedure pPopulaIndNre();
    procedure pCriaIndNRF();
    procedure pPopulaIndNRF();
    procedure pCriaIndCpj();
    procedure pPopulaIndCpj();
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadContribuicaoRetidaFonte: TfrmCadContribuicaoRetidaFonte;

implementation

uses untTypesSistema, untFuncoesSimples, untConsultas, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmCadContribuicaoRetidaFonte.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If blnAlterou Then
  Begin
    dbeIndNre.Enabled := True;
    dbeIndNRF.Enabled := True;
    dbeIndCpj.Enabled := True;
  End;
end;

procedure TfrmCadContribuicaoRetidaFonte.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbeIndNre.Enabled := False;
  dbeIndNRF.Enabled := False;
  dbeIndCpj.Enabled := False;
end;

procedure TfrmCadContribuicaoRetidaFonte.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadContribuicaoRetidaFonte.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadContribuicaoRetidaFonte.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('REF_CODEMP').AsString := VS_strCodEmp;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadContribuicaoRetidaFonte.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    dbeIndNre.Enabled := False;
    dbeIndNRF.Enabled := False;
    dbeIndCpj.Enabled := False;
  End
  Else
    fRollBack;
end;

procedure TfrmCadContribuicaoRetidaFonte.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeIndNre.Enabled := True;
  dbeIndNRF.Enabled := True;
  dbeIndCpj.Enabled := True;
end;

procedure TfrmCadContribuicaoRetidaFonte.btnPesquisaClick(Sender: TObject);
var
  arrContRetFonte : TConsultasArray;
  chrKey : Char;
begin
  chrKey := '/';
  If fPesqContriRetidaFonte(Self, qryTabela, chrKey, arrContRetFonte) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadContribuicaoRetidaFonte.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'CONREF';
  strNomeCampo        := 'AUTOINCREM';
  qryTabela           := fCriaQuery(Self);
  dtsTabela.DataSet   := qryTabela;

  pCriaIndNre();
  pPopulaIndNre();

  pCriaIndNRF();
  pPopulaIndNRF();

  pCriaIndCpj();
  pPopulaIndCpj();

  dtsIndNre.DataSet := cdsIndNre;
  dtsIndNRF.DataSet := cdsIndNRF;
  dtsIndCpj.DataSet := cdsIndCpj;
end;

procedure TfrmCadContribuicaoRetidaFonte.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsIndNre);
  FreeAndNil(cdsIndNRF);
  FreeAndNil(cdsIndCpj);
end;

procedure TfrmCadContribuicaoRetidaFonte.pCriaIndNre();
begin
  cdsIndNre := TUniClientDataSet.Create(Self);

  With cdsIndNre.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODTIP';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsIndNre.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESTIP';
    DataType := ftString;
    Size     := 250;
  End;

  cdsIndNre.CreateDataSet;
  cdsIndNre.IndexFieldNames := 'CODTIP';
  cdsIndNre.LogChanges := False;
end;

procedure TfrmCadContribuicaoRetidaFonte.pPopulaIndNre();

  procedure pInsert(strCodTip, strDesTip: String);
  begin
    cdsIndNre.Insert;
    cdsIndNre.FieldByName('CODTIP').AsString := strCodTip;
    cdsIndNre.FieldByName('DESTIP').AsString := strDesTip;
    cdsIndNre.Post;
  end;

begin
  pInsert('0', '0 - Receita de natureza não cumulativa');
  pInsert('1', '1 - Receita de natureza cumulativa');
end;

procedure TfrmCadContribuicaoRetidaFonte.pCriaIndNRF();
begin
  cdsIndNRF := TUniClientDataSet.Create(Self);

  With cdsIndNRF.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODTIP';
    DataType := ftString;
    Size     := 2;
  End;

  With cdsIndNRF.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESTIP';
    DataType := ftString;
    Size     := 250;
  End;

  cdsIndNRF.CreateDataSet;
  cdsIndNRF.IndexFieldNames := 'CODTIP';
  cdsIndNRF.LogChanges := False;
end;

procedure TfrmCadContribuicaoRetidaFonte.pPopulaIndNRF();

  procedure pInsert(strCodTip, strDesTip: String);
  begin
    cdsIndNRF.Insert;
    cdsIndNRF.FieldByName('CODTIP').AsString := strCodTip;
    cdsIndNRF.FieldByName('DESTIP').AsString := strDesTip;
    cdsIndNRF.Post;
  end;

begin
  pInsert('01', '01 - Retenção por órgãos, autarquias e fundações federais');
  pInsert('02', '02 - Retenção por outras entidades da administração pública federal');
  pInsert('03', '03 - Retenção por pessoas jurídicas de direito privado');
  pInsert('04', '04 - Recolhmento por sociedade cooperativa');
  pInsert('05', '05 - Retenção por fabricante de máquinas e veículos');
  pInsert('99', '99 - Outras retenções');
end;

procedure TfrmCadContribuicaoRetidaFonte.pCriaIndCpj();
begin
  cdsIndCpj := TUniClientDataSet.Create(Self);

  With cdsIndCpj.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODTIP';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsIndCpj.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESTIP';
    DataType := ftString;
    Size     := 250;
  End;

  cdsIndCpj.CreateDataSet;
  cdsIndCpj.IndexFieldNames := 'CODTIP';
  cdsIndCpj.LogChanges := False;
end;

procedure TfrmCadContribuicaoRetidaFonte.pPopulaIndCpj();

  procedure pInsert(strCodTip, strDesTip: String);
  begin
    cdsIndCpj.Insert;
    cdsIndCpj.FieldByName('CODTIP').AsString := strCodTip;
    cdsIndCpj.FieldByName('DESTIP').AsString := strDesTip;
    cdsIndCpj.Post;
  end;

begin
  pInsert('0', '0 – Beneficiária da Retenção / Recolhimento');
  pInsert('1', '1 - Responsável pelo Recolhimento');
end;

procedure TfrmCadContribuicaoRetidaFonte.FormShow(Sender: TObject);
begin
  inherited;
  dbeIndNre.Enabled := False;
  dbeIndNRF.Enabled := False;
  dbeIndCpj.Enabled := False;
end;

function TfrmCadContribuicaoRetidaFonte.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeDtaRet) Then
    Begin
      If Not fEmptyStr(dbeDtaRet.Text) Then
      Begin
        Try
          StrToDate(dbeDtaRet.Text);
        Except
          Result := False;
          fMensagem('ATENÇÃO!', 'Data Retenção inválida! Formato correto: DD/MM/AAAA.', ['&Ok']);
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadContribuicaoRetidaFonte.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('REF_CODEMP');
  stlCamInd.Add('REF_DTARET');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Data Retenção');
end;

end.
