unit untCadAliqIBPT;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, DBEditFocus, DB, Uni,
  untCadIBPT, DBCtrls, frxClass, frxExportCSVTestabilidade, Vcl.Graphics;

type
  TfrmCadAliqIBPT = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label1: TLabel;
    dbeNCM: TDBEditFocus;
    dtsCadIBP: TDataSource;
    dbeAlqNac: TDBEditFocus;
    Label18: TLabel;
    Label2: TLabel;
    dbeAlqImp: TDBEditFocus;
    dbeEstado: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbee_x___: TDBEditFocus;
    dbeAlqEst: TDBEditFocus;
    Label5: TLabel;
    dbeAlqMun: TDBEditFocus;
    Label6: TLabel;
    btnImportarPlanilha: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeNCMKeyPress(Sender: TObject; var Key: Char);
    procedure dbee_x___KeyPress(Sender: TObject; var Key: Char);
    procedure dbee_x___Exit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnImportarPlanilhaClick(Sender: TObject);
  private
    { Private declarations }
    objCadIBPT: TCadIBPT;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples, untConsultas, untConstantes, untTypesSistema,
     untImportAliquotaIBPT;

{$R *.dfm}

procedure TfrmCadAliqIBPT.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeEstado , dbeAlqNac, False);
  pHabilitaCodigo(dbeNCM ,    dbeAlqNac, False);
  pHabilitaCodigo(dbee_x___ , dbeAlqNac, False);
end;

procedure TfrmCadAliqIBPT.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAliqIBPT.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAliqIBPT.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadAliqIBPT.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAliqIBPT.btnImportarPlanilhaClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmImportAliquotaIBPT, frmImportAliquotaIBPT);
end;

procedure TfrmCadAliqIBPT.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeEstado.Text := fCadEmp('ESTADO');
  pHabilitaCodigo(dbeEstado, dbeNCM, False);
  dbee_x___.Color := clWindow;
end;

procedure TfrmCadAliqIBPT.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrIBPT: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE ALÍQ IBPT  *}
  {****************************NC*}
  chrKey := '/';
  If fPesqAlqIBPT(Self, Nil, Nil, qryTabela, chrKey, arrIBPT) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadAliqIBPT.dbee_x___Exit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(dbee_x___.Text)) And (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    qryTabela.FieldByName('IBP_E_X___').AsString := fStrZero(dbee_x___.Text, 3);
    dbee_x___.Text := fStrZero(dbee_x___.Text, 3);
  End;
end;

procedure TfrmCadAliqIBPT.dbee_x___KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = ',') Then
    Key := #0;
end;

procedure TfrmCadAliqIBPT.dbeNCMKeyPress(Sender: TObject; var Key: Char);
Var
  qryConGen: TUniQuery;
  arrSel : TConsultasArray;
begin
  inherited;
  If Key = '/' Then
  Begin
    qryConGen := fCriaQuery;

    dbeNCM.Clear;

    If fPesqClaIPI(Self, dbeNCM, qryConGen, Key, arrSel) Then
    Begin
      pSetFocus(dbeAlqNac);
    End;

    FreeAndNil(qryConGen);
  End;
end;

procedure TfrmCadAliqIBPT.FormCreate(Sender: TObject);
begin
  objCadIBPT := TCadIBPT.Create(Self);

  inherited;

  strNomeTabela         := 'CADIBP';
  strNomeCampo          := 'IBP_N_C_M_';

  qryTabela             := objCadIBPT.qryTabela;
  dtsCadIBP.DataSet     := qryTabela;

  SetLength(arrCamposChave, 3);
  arrCamposChave[0]     := dbeNCM;
  arrCamposChave[1]     := dbeEstado;
  arrCamposChave[2]     := dbee_x___;
end;

function TfrmCadAliqIBPT.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    Try
      If (Sender = dbeNCM) Then
      Begin
        If dbeNCM.Enabled Then
          objCadIBPT.strN_C_M_ := dbeNCM.Text

        Else If (blnBuscaPorChave) And (Not fBuscaPorCamposChave) Then
          pLimparCampos;
      End

      Else If (Sender = dbeEstado) Then
        objCadIBPT.strEstado := dbeEstado.Text

      Else If (Sender = dbee_x___) Then
        objCadIBPT.strE_X___ := dbee_x___.Text

      Else If (Sender = dbeAlqNac) Then
        objCadIBPT.strAlqNac := dbeAlqNac.Text

      Else If (Sender = dbeAlqNac) Then
        objCadIBPT.strAlqNac := dbeAlqNac.Text

      Else If (Sender = dbeAlqImp) Then
        objCadIBPT.strAlqImp := dbeAlqImp.Text

      Else If (Sender = dbeAlqEst) Then
        objCadIBPT.strAlqEst := dbeAlqEst.Text

      Else If (Sender = dbeAlqMun) Then
        objCadIBPT.strAlqMun := dbeAlqMun.Text;

    Except
      On E: ExceptionAutCom Do
      Begin
        Result := False;
        fMensagem('',E.Message,['&Ok']);
      End;

      On E: Exception Do
      Begin
        Result := False;      
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAliqIBPT.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('IBP_N_C_M_');
  stlCampos.Add('IBP_ALQNAC');
  stlCampos.Add('IBP_ALQIMP');
  stlCampos.Add('IBP_E_X___');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('IBP_N_C_M_');
  stlCamInd.Add('IBP_ALQNAC');
  stlCamInd.Add('IBP_ALQIMP');
  stlCamInd.Add('IBP_E_X___');

  stlDesInd.Add('NCM');
  stlDesInd.Add('Alíquota Nacionais');
  stlDesInd.Add('Alíquota Importados');
  stlDesInd.Add('EX');
end;

end.

