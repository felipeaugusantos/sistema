unit untCadBoxWms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB;

type
  TfrmCadBoxWms = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodBox: TDBEditFocus;
    Label2: TLabel;
    DBEditFocus1: TDBEditFocus;
    Label3: TLabel;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    Label4: TLabel;
    dtsTabela: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
  public
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

procedure TfrmCadBoxWms.btnAlterarClick(Sender: TObject);
begin
  If blnUsaProCodigo Then
  Begin
    pMensagemOK('Não é permitido alterar esse registro!');
    Exit;
  End;

  inherited;

  pHabilitaCodigo(dbeCodBox, dbeCodBox, True);

end;

procedure TfrmCadBoxWms.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadBoxWms.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadBoxWms.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadBoxWms.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadBoxWms.btnIncluirClick(Sender: TObject);
begin
  inherited;
  qryTabela.FieldByName('BOX_CODEMP').AsString := VS_strCodEmp;

  If blnUsaProCodigo Then
    btnGravar.Click
  Else
    pHabilitaCodigo(dbeCodBox, dbeCodBox, True);


end;

procedure TfrmCadBoxWms.btnPesquisaClick(Sender: TObject);
  Var
    chrChar : Char;
    arrSel : TConsultasArray;
begin
  inherited;
  chrChar := '/';
  If fPesqBoxWms(Self, Nil, qryTabela, chrChar, arrSel) Then
  Begin
    If blnUsaProCodigo Then
      btnAlterar.Enabled := False // Se usa o sequencial de Proximo código não tem o que alterar nesse cadastro!
    Else
      pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadBoxWms.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADBOX';
  strNomeCampo      := 'BOX_CODIGO';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodBox;

end;

procedure TfrmCadBoxWms.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

  inherited;
end;

function TfrmCadBoxWms.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = dbeCodBox) And (not blnUsaProCodigo) Then
    Begin
      Result := not fEmptyStr(dbeCodBox.Text);
      If not Result Then
        pMensagemOK('Digite o Codigo do Box!');
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadBoxWms.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

end;

end.
