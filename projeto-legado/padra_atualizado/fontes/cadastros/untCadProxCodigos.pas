unit untCadProxCodigos;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, Mask, DBCtrls, DBEditFocus,
  ComCtrls, Buttons, ExtCtrls, DB, Menus, AppEvnts, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadProxCodigos = class(TfrmPaiCad)
    dbeNomArq: TDBEditFocus;
    dbeTamCod: TDBEditFocus;
    dbeValCod: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodAut: TDBCheckBox;
    pnlFundo: TPanel;
    dtsProCod: TDataSource;
    dbeSeqEmp: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeValCodExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    function fArquivoDesativado(const AArquivo: string):boolean ;
    procedure pAtualizaStatusDesativado(const AArquivo: string) ;
    function fValidaTamCampoArq(const AArquivo: String): Boolean;
  protected
    procedure pInicializaIndices; override;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untModulo, untFuncoesSimples, untPai, untConsultas, Generics.Defaults,
  Generics.Collections;

{$R *.dfm}

const
  MSG_DESATIVADOS = 'Arquivo desativado para alteração!' ;
  PROCOD_DESATIVADOS : TArray<String> = ['CTACON'];

procedure TfrmCadProxCodigos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'PROCOD';
  strNomeCampo      := 'PRO_NOMARQ';
  qryTabela         := frmModulo.qryProCod;
  dtsProCod.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeNomArq;
end;

function TfrmCadProxCodigos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If Sender = dbeTamCod Then
    Begin
      If fEmptyStr(dbeTamCod.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tamanho do campo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If StrToInt64(dbeTamCod.Text) < 1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tamanho do campo deve ser maior ou igual a 1!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Result := fValidaTamCampoArq(dbeNomArq.Text);
      End;
    End

    Else If Sender = dbeNomArq Then
    Begin
      If fEmptyStr(dbeNomArq.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O nome do arquivo não pode ser vazio!', ['&Ok']);
        Result := False;
      End
      Else If Pos(' ', dbeNomArq.Text) > 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O nome do arquivo não pode conter espaços!', ['&Ok']);
        Result := False;
      End
      Else If (Length(Trim(dbeNomArq.Text)) > 15) Then
      Begin
        fMensagem('ATENÇÃO!', 'Nome de arquivo inválido!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          pLimparCampos;
          dbeCodAut.Checked := False;
        End;
      End;
    End

    Else If Sender = dbeValCod Then
    Begin
      Try
        StrToInt64(dbeValCod.Text)
      Except
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Valor do campo inconsistente!', ['&Ok']);
        Exit;
      End;
      End;

      If fEmptyStr(dbeValCod.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do campo não pode ser vazio!', ['&Ok']);
        Result := False;
      End
{      Else If Length(Trim(dbeValCod.Text)) <> StrToInt(dbeTamCod.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do campo deve conter exatamente ' + dbeTamCod.Field.AsString + ' caracteres!', ['&Ok']);
        Result := False;
      End}
      Else If StrToInt64(dbeValCod.Text) = 0 Then
      Begin
        dbeValCod.Clear;
        Result := False;
      End
      Else If (Length(dbeValCod.Text) > StrToInt64(dbeTamCod.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tamanho do valor do campo deve ser menor ou igual a ' + dbeTamCod.Text + '!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Not fEmptyStr(dbeTamCod.Text) Then
        Begin
          dbeValCod.Text := fStrZero(dbeValCod.Text, StrToInt64(dbeTamCod.Text));
        End;
      End;
    End;
  End;

  If Not Result Then
  Begin
    pSetFocus(TWinControl(Sender));
  End;
end;

function TfrmCadProxCodigos.fValidaTamCampoArq(const AArquivo: String): Boolean;
begin
  Result := True;

  If SameStr(AArquivo, 'CADCLI') Then
  Begin
    If StrToInt64(dbeTamCod.Text) <> VS_intTamCodCli Then
    Begin
      fMensagem('ATENÇÃO!', 'O Tamanho do campo deve ser igual a '+ VS_intTamCodCli.ToString +'!', ['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmCadProxCodigos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('PRO_NOMARQ');
  stlCampos.Add('PRO_CODAUT');
  stlCampos.Add('PRO_CODSEQ');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('PRO_NOMARQ');
  stlDesInd.Add('Nome do arquivo');
end;

procedure TfrmCadProxCodigos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeNomArq, dbeNomArq, True);
end;

procedure TfrmCadProxCodigos.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
begin
  {**********************************}
  {* NOVA CONSULTA DE PRÓX. CÓDIGOS *}
  {*******************************RV*}
  chrKey := '/';
  If fPesqProCod(Self, Nil, qryTabela, chrKey) Then
  Begin
    pAtualizaStatusDesativado(dbeNomArq.Field.AsString) ;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadProxCodigos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadProxCodigos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadProxCodigos.btnGravarClick(Sender: TObject);
  Var
    qryProInc: TUniQuery;
begin
  If (qryTabela.State = dsInsert) Then
  Begin
    qryTabela.FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If blnGravou Then
    Begin
      qryProInc := fCriaQuery(Self);
      qryProInc.SQL.Add('SELECT * FROM PROINC WHERE PRO_NOMARQ = :NOMARQ');
      qryProInc.ParamByName('NOMARQ').AsString := qryTabela.FieldByName('PRO_NOMARQ').AsString;
      qryProInc.Open;

      If qryProInc.IsEmpty Then
      Begin
        qryProInc.Append;
        qryProInc.FieldByName('PRO_NOMARQ').AsString := qryTabela.FieldByName('PRO_NOMARQ').AsString;
        qryProInc.FieldByName('PRO_AUTINC').AsString := '1';
        qryProInc.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PROCOD', VS_strCodEmp);
        qryProInc.Post;
      End;
      FreeAndNil(qryProInc);

      fCommit;
    End
    Else
    Begin
      fRollBack;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadProxCodigos.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadProxCodigos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeNomArq, dbeNomArq, True);
end;

procedure TfrmCadProxCodigos.dbeValCodExit(Sender: TObject);
  Var
    strValCod: String;
begin
  inherited;

  strValCod := TDBEditFocus(Sender).Text;

  Try
    If StrToInt64(TDBEditFocus(Sender).Text) < 0 then
    Begin
      pSetFocus(TDBEditFocus(Sender));
      TDBEditFocus(Sender).Text := strValCod;
    End;
  Except
    Begin
      fMensagem('ATENÇÃO!', 'Valor do campo inconsistente ou negativo!', ['&Ok']);
      pSetFocus(TDBEditFocus(Sender));
      TDBEditFocus(Sender).Text := strValCod;
    End;
  End;
end;

function TfrmCadProxCodigos.fArquivoDesativado(const AArquivo: string): boolean;
var
  strItem: string ;
begin
  result := False ;
  for strItem in PROCOD_DESATIVADOS do
  begin
    if AArquivo = strItem then
    begin
      result := True ;
      break ;
    end;
  end;
end;

procedure TfrmCadProxCodigos.pAtualizaStatusDesativado(const AArquivo: string);
var
  blnDesativado: boolean ;
begin
  blnDesativado := fArquivoDesativado(AArquivo) ;
  if not blnDesativado then
  begin
    pnlInfo.Caption := '' ;
  end
  else
  begin
    pnlInfo.Caption := MSG_DESATIVADOS ;
  end;
  btnIncluir.Enabled := not blnDesativado ;
  btnAlterar.Enabled := not blnDesativado ;
  btnExcluir.Enabled := not blnDesativado ;
end;

end.

