unit untCadVenDiaEmp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel, EditFocus, Uni, StrUtils, UniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar;

type
  TfrmCadVenDiaEmp = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    pnlGeral: TPanel;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    Label3: TLabel;
    Label5: TLabel;
    dbeDtaAju: TDBEditFocus;
    Label7: TLabel;
    dbeValAju: TDBEditFocus;
    mskDtaAju: TcxDateEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmpExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

Var
  frmCadVenDiaEmp : TfrmCadVenDiaEmp;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas, untFuncoesConsulta;

{ TfrmCadVenDiaEmp }

procedure TfrmCadVenDiaEmp.btnAlterarClick(Sender: TObject);
begin
  inherited;
  mskDtaAju.Enabled := True;
end;

procedure TfrmCadVenDiaEmp.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  mskDtaAju.Text := dbeDtaAju.Text;
  mskDtaAju.Enabled := False;
end;

procedure TfrmCadVenDiaEmp.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadVenDiaEmp.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    mskDtaAju.Enabled := False;
  End
  Else
    fRollBack;

  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  mskDtaAju.Text := dbeDtaAju.Text;
end;

procedure TfrmCadVenDiaEmp.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadVenDiaEmp.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    mskDtaAju.Enabled := False;
  End
  Else
    fRollBack;
end;

procedure TfrmCadVenDiaEmp.btnIncluirClick(Sender: TObject);
begin
  inherited;
  edtNomEmp.Text := '';
  mskDtaAju.Text := '';
  mskDtaAju.Enabled := True;
end;

procedure TfrmCadVenDiaEmp.btnPesquisaClick(Sender: TObject);
var
  arrAjuste : TConsultasArray;
  chrKey : Char;
begin
  chrKey := '/';
  If fPesqVenDiaEmp(Self, qryTabela, chrKey, arrAjuste) Then
    pSetFocus(btnAlterar);

  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  mskDtaAju.Text := dbeDtaAju.Text;
end;

procedure TfrmCadVenDiaEmp.dbeCodEmpExit(Sender: TObject);
var
  arrEmpresa: TConsultasArray;
begin
  pEdtCodSelectExit(dbeCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmCadVenDiaEmp.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
var
  arrEmpresa: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCampos(dbeCodEmp, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadVenDiaEmp.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadVenDiaEmp.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'VENAJU';
  strNomeCampo        := 'AUTOINCREM';
  qryTabela           := fCriaQuery(Self);
  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodEmp;
  arrCamposChave[1] := dbeDtaAju;
end;

function TfrmCadVenDiaEmp.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodEmp) Then
    Begin
      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&Ok']);
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
      End;
    End
    Else If (Sender = mskDtaAju) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaAju.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Ajuste deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Try
          qryTabela.FieldByName('AJU_DTAAJU').AsDateTime := StrToDate(mskDtaAju.Text);
          dbeDtaAju.Text := mskDtaAju.Text;
        Except
          fMensagem('ATENÇÃO!', 'Data do Ajuste inválida!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeValAju) Then
    Begin
      If fEmptyStr(dbeValAju.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Valor do Ajuste deve ser preenchido!', ['&Ok']);
      End;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadVenDiaEmp.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AJU_CODEMP');
  stlCampos.Add('AJU_DTAAJU');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('AJU_CODEMP');
  stlCamInd.Add('AJU_DTAAJU');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Data Ajuste');
end;

end.
