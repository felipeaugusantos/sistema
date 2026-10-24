unit untCadFaixaFatuEstimadoCRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadFaixaFatuEstimadoCRM = class(TfrmPaiCad)
    dtsSource: TDataSource;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeFatIni: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeFatFin: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    procedure pSetFormatacao;
  public
    { Public declarations }
  Protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmCadFaixaFatuEstimadoCRM }

procedure TfrmCadFaixaFatuEstimadoCRM.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFaixaFatuEstimadoCRM.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFaixaFatuEstimadoCRM.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadFaixaFatuEstimadoCRM.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFaixaFatuEstimadoCRM.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDescri);
  qryTabela.FieldByName('CRF_FATINI').AsFloat := 0.00;
  qryTabela.FieldByName('CRF_FATFIN').AsFloat := 0.00;
  pSetFormatacao;
end;

procedure TfrmCadFaixaFatuEstimadoCRM.btnPesquisaClick(Sender: TObject);
  Var
    Key: Char;
    arrSel: TConsultasArray;
begin
  inherited;
  Key := '/';
  If fPesqFaixaFaturamentoCRM(Self, Nil, Nil, qryTabela, Key, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
    pSetFormatacao;
  End;
end;

procedure TfrmCadFaixaFatuEstimadoCRM.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CRMFAI';
  strNomeCampo      := 'CRF_CODIGO';
  qryTabela         := fCriarQuery('SELECT * FROM CRMFAI', Self);
  dtsSource.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

end;

procedure TfrmCadFaixaFatuEstimadoCRM.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

function TfrmCadFaixaFatuEstimadoCRM.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Digite uma Descrição!', ['&Ok']);
      End;
    End

    Else
    If (Sender = dbeFatIni) Then
    Begin
      If fStrToFloat(dbeFatIni.Text) < 0 Then
      Begin
        Result := False;
        fMensagem('', 'Digite um valor maior que zero!', ['&Ok']);
      End;
    End

    Else
    If (Sender = dbeFatFin) Then
    Begin
      If fStrToFloat(dbeFatFin.Text) < 0 Then
      Begin
        Result := False;
        fMensagem('', 'Digite um valor maior que zero!', ['&Ok']);
      End
      Else
      If fStrToFloat(dbeFatFin.Text) < fStrToFloat(dbeFatIni.Text) Then
      Begin
        Result := False;
        fMensagem('', 'O faturamento final deve ser maior que o faturamento inicial!', ['&Ok']);
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadFaixaFatuEstimadoCRM.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CRF_CODIGO');
  stlCampos.Add('CRF_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CRF_DESCRI');
  stlCamInd.Add('CRF_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadFaixaFatuEstimadoCRM.pSetFormatacao;
begin
  TFloatField(qryTabela.FieldByName('CRF_FATINI')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('CRF_FATFIN')).DisplayFormat := '#,##0.00';
end;

end.
