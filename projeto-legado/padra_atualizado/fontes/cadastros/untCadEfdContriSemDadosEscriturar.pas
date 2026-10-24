unit untCadEfdContriSemDadosEscriturar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, ComboBoxFocus,
  Data.DB, untTypesSistema, frxClass, frxExportCSVTestabilidade, Vcl.Menus,
  Vcl.ComCtrls, BitBtnLockedIncrem, Uni, StrUtils;

type
  TfrmCadEfdContriSemDadosEscriturar = class(TfrmPaiCad)
    Panel1: TPanel;
    lbl1: TLabel;
    lblTipo: TLabel;
    Label1: TLabel;
    dtsEfdSde: TDataSource;
    pnlCentral: TPanel;
    Label2: TLabel;
    edtMesAno: TDBEditFocus;
    cmbCodInf: TComboBoxFocus;
    Label3: TLabel;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryEfdSDE: TUniQuery;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadEfdContriSemDadosEscriturar: TfrmCadEfdContriSemDadosEscriturar;

implementation

uses untFuncoesSimples, untConsultas, untFuncoes, untFuncoesConsulta,
  Contabilidade.Funcoes;

{$R *.dfm}

function TfrmCadEfdContriSemDadosEscriturar.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtMesAno) Then
    Begin
      If fEmptyStr(edtMesAno.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Mês/Ano é de preenchimento obrigatório!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        Try
          StrToDate('01/' + LeftStr(edtMesAno.Text, 2) + '/' + RightStr(edtMesAno.Text, 4));
        Except
          fMensagem('ATENÇÃO!', 'Mês/Ano inválido!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = cmbCodInf) Then
    Begin
      If cmbCodInf.ItemIndex < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Informação Complementar do Registro é de preenchimento obrigatório!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadEfdContriSemDadosEscriturar.btnAlterarClick(Sender: TObject);
begin
  inherited;
  cmbCodInf.Enabled := True;
  pSetFocus(edtMesAno);
end;

procedure TfrmCadEfdContriSemDadosEscriturar.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cmbCodInf.ItemIndex := AnsiIndexStr(qryTabela.FieldByName('SDE_CODINF').AsString, ['01', '02', '03', '04', '05', '06', '07', '99']);
  cmbCodInf.Enabled := False;
end;

procedure TfrmCadEfdContriSemDadosEscriturar.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEfdContriSemDadosEscriturar.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    cmbCodInf.ItemIndex := -1;
    cmbCodInf.Enabled := False;
  End
  Else
    fRollBack;

end;

procedure TfrmCadEfdContriSemDadosEscriturar.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('SDE_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('SDE_CODINF').AsString := LeftStr(cmbCodInf.Items[cmbCodInf.ItemIndex], 2);
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEfdContriSemDadosEscriturar.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    cmbCodInf.Enabled := False;
  End
  Else
    fRollBack;
end;

procedure TfrmCadEfdContriSemDadosEscriturar.btnIncluirClick(Sender: TObject);
begin
  inherited;
  cmbCodInf.ItemIndex := -1;
  cmbCodInf.Enabled := True;
  pSetFocus(edtMesAno);
end;

procedure TfrmCadEfdContriSemDadosEscriturar.btnPesquisaClick(Sender: TObject);
var
  arrConsulta : TConsultasArray;
  chrKey : Char;
begin
  chrKey := '/';
  If fPesqEfdContriSDE(Self, qryTabela, chrKey, arrConsulta) Then
  begin
    cmbCodInf.ItemIndex := AnsiIndexStr(qryTabela.FieldByName('SDE_CODINF').AsString, ['01', '02', '03', '04', '05', '06', '07', '99']);
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmCadEfdContriSemDadosEscriturar.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'EFDSDE';
  strNomeCampo  := 'AUTOINCREM';

  strSQL            := 'SELECT * FROM EFDSDE WHERE SDE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  qryEfdSDE         := fCriarQuery(strSQL, Self);
  qryTabela         := qryEfdSDE;
  dtsEfdSde.DataSet := qryTabela;
end;

procedure TfrmCadEfdContriSemDadosEscriturar.FormDestroy(Sender: TObject);
begin
  stlCampos.Free;
  stlCamInd.Free;
  stlDesInd.Free;

  inherited;
end;

procedure TfrmCadEfdContriSemDadosEscriturar.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('SDE_CODEMP');
  stlCampos.Add('SDE_MESANO');
  stlCampos.Add('SDE_CODINF');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('SDE_CODEMP');
  stlCamInd.Add('SDE_MESANO');
  stlCamInd.Add('SDE_CODINF');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Mês/Ano');
  stlDesInd.Add('Cód.Inf.');
end;

end.
