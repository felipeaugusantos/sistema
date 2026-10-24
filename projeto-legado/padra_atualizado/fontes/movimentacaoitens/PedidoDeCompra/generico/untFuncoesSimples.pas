unit untFuncoesSimples;

interface

uses SysUtils, StrUtils, Graphics, Dialogs, Forms, Buttons, Uni, Classes;

  procedure pFreeAndNil(frmForm: TForm);

  function fEmptyStr(strString : String) : Boolean;
  Function fMensagem(strTitulo: String; strTexto: String; arrOpcoes: Array Of String; intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1): Integer;
  function fIsNumber(Const strNumber: String): Boolean;
  function fValidaProCod(strNomeTabela: String): Boolean;
  function fAbrirTabela(NomeTabela:TUniQuery):Boolean;
  function fFecharTabela(NomeTabela:TUniQuery):Boolean;
  function fCriaQuery(AOwner: TComponent = Nil): TUniQuery;
  Function fRetEmpresaFisica: String;

Var
  strEmpAcessoUsuarioLogado: String;
  VS_strCodEmp: String;

implementation

uses untMensagem;

function fEmptyStr(strString : String) : Boolean;
begin
  Result := False;
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');
  If AnsiReplaceText(strString, ' ', '') = '' Then
    Result := True;
end;

{*****************************************************************************************}
{*                                                                                       *}
{* -> Funcao Mensagem                                                                    *}
{*                                                                                       *}
{*    - Parametros:                                                                      *}
{*      1) Titulo                                                                        *}
{*      2) Texto                                                                         *}
{*      3) Matriz com o nome para até 03 botoes, sendo que vc pode passar ['',''] para   *}
{*         a funcao atribuir automaticamente Sim / Nao como Default                      *}
{***********************************************************************************MV*WI*}
Function fMensagem(strTitulo: String; strTexto: String; arrOpcoes: Array Of String; intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1): Integer;
  Var
    intQtdOpcoes : Integer;
    intPosicao   : Integer;
    fntFonte     : TFont;
begin
  intQtdOpcoes   := 0;

  fntFonte       := TFont.Create;
  fntFonte.Name  := 'charter';
  fntFonte.Size  := 13;
  //fntFonte.Style := [fsBold];

  For intPosicao := 0 To Length( arrOpcoes )-1 Do
  Begin
    If arrOpcoes[intPosicao] <> '' Then
      Inc(intQtdOpcoes)
    Else
      Break;
  End;

  If (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&Não';
    intQtdOpcoes := 2;
  End;

  If Trim(arrOpcoes[0]) = '' Then
  Begin
    MessageDlg('É obrigatório a passagem dos parametros em ordem!', mtInformation, [mbOK], 0);
    Result := 0;
    Exit;
  End;

  {********************************}
  {* -> Define Foco para Botao    *}
  {*****************************WI*}
  If ( intFocoBotao <= 0 )           Or
     ( intFocoBotao > intQtdOpcoes ) Then
    intFocoBotao := 1;

  Application.CreateForm(TfrmMensagem, frmMensagem);

  With frmMensagem Do
  Begin

    If strTitulo = '' Then
      strTitulo := 'AVISO';

    If intEstFon = 2 Then
      lblMensagem.Font.Name := 'Courier New';

    lblTitulo.Caption   := strTitulo;
    lblMensagem.Caption := strTexto;

    If intQtdOpcoes = 1 Then
    Begin
      With TBitBtn.Create(frmMensagem) Do
      Begin
        parent     := pnlBotoes;
        Left       := 156;
        Top        := 05;
        Height     := 28;
        Width      := 126;
        Font       := fntFonte;
        Caption    := arrOpcoes[0];
        Tag        := 1;
        Glyph      := imgbotao1.Picture.Bitmap;
        OnClick    := frmMensagem.pOnclick;
      End;
    End
    Else If intQtdOpcoes = 2 Then
    Begin
      With TBitBtn.Create(frmMensagem) Do
      Begin
        parent     := pnlBotoes;
        Left       := 92;
        Top        := 05;
        Height     := 28;
        Width      := 126;
        Font       := fntFonte;
        Caption    := arrOpcoes[0];
        Tag        := 1;
        Glyph      := imgbotao1.Picture.Bitmap;
        OnClick    := frmMensagem.pOnclick;
      End;
      With TBitBtn.Create(frmMensagem) Do
      Begin
        parent     := pnlBotoes;
        Left       := 220;
        Top        := 05;
        Height     := 28;
        Width      := 126;
        Font       := fntFonte;
        Caption    := arrOpcoes[1];
        Tag        := 2;
        Glyph      := imgbotao2.Picture.Bitmap;
        OnClick    := frmMensagem.pOnclick;
      End;
    End
    Else If intQtdOpcoes = 3 Then
    Begin
      With TBitBtn.Create(frmMensagem) Do
      Begin
        parent     := pnlBotoes;
        Left       := 28;
        Top        := 05;
        Height     := 28;
        Width      := 126;
        Font       := fntFonte;
        Caption    := arrOpcoes[0];
        Tag        := 1;
        Glyph      := imgbotao1.Picture.Bitmap;
        OnClick    := frmMensagem.pOnclick;
      End;
      With TBitBtn.Create(frmMensagem) Do
      Begin
        parent     := pnlBotoes;
        Left       := 156;
        Top        := 05;
        Height     := 28;
        Width      := 126;
        Font       := fntFonte;
        Caption    := arrOpcoes[1];
        Tag        := 2;
        Glyph      := imgbotao2.Picture.Bitmap;
        OnClick    := frmMensagem.pOnclick;
      End;
      With TBitBtn.Create(frmMensagem) Do
      Begin
        parent     := pnlBotoes;
        Left       := 284;
        Top        := 05;
        Height     := 28;
        Width      := 126;
        Font       := fntFonte;
        Caption    := arrOpcoes[2];
        Tag        := 3;
        Glyph      := imgbotao3.Picture.Bitmap;
        OnClick    := frmMensagem.pOnclick;
      End;
    End;
  End;

  frmMensagem.intFocus     := intFocoBotao;
  frmMensagem.blnSaiComEsc := blnSaiComEsc;
  frmMensagem.ShowModal;
  Result := frmMensagem.intRetorno;

  FreeAndNil(fntFonte);
  pFreeAndNil(frmMensagem);
end;

procedure pFreeAndNil(frmForm: TForm);
Begin
  frmForm.Release;
  frmForm.Free;
End;

{*****************************************}
{* VERIFICA SE A STRING É UM NUMERO      *}
{**************************************MV*}
function fIsNumber(Const strNumber: String): Boolean;
  Var
    Code: Integer;
    E: Integer;
begin

  Result := False;

  If (fEmptyStr(strNumber)) Then
  Begin
    Exit;
  End;

  Val(strNumber, E, Code);
  If (Code = 0) Then //Usado para eliminar o Hint...
  Begin
    E := 0;
    Result := True;
  End;

  If (E = 0) Then
  Begin
  End;
end;

function fValidaProCod(strNomeTabela: String): Boolean;
  Var
    strSQL     : String;
    qryGenCod  : TUniQuery;
    intContador: Integer;
begin
  Try

    qryGenCod := fCriaQuery;

    Result := True;
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PRO_NOMARQ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

    With qryGenCod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMARQ').AsString := strNomeTabela;
      Open;
      If IsEmpty Then
      Begin
        For intContador := 0 To Length(arrProCod) - 1 Do
          Begin
            If (strNomeTabela = arrProCod[intContador].strNomArq)  Then
            Begin
              Close;
              SQL.Clear;
              SQL.Add(' SELECT * FROM PROCOD');
              Open;
              Insert;
              FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
              FieldByName('PRO_CODSEQ').AsString  := arrProCod[intcontador].strCodSeq;
              FieldByName('PRO_TAMCOD').AsInteger := arrProCod[intcontador].intTamCod;
              FieldByName('PRO_AUTINC').AsInteger := arrProCod[intcontador].intAutInc;
              FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
              FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
              FieldByName('PRO_CODAUT').AsString  := 'S';
              Post;
              Close;
              Break;
            End;
          End;

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        Open;
        If IsEmpty Then
        Begin
          Close;
          Result := False;
        End;
      End;
    End;

  Finally
    FreeAndNil(qryGenCod);
  End;

end;

function fAbrirTabela(NomeTabela:TUniQuery):Boolean;
begin
  Try
	  If NomeTabela.Active = False Then
      NomeTabela.Open;

	  Result := True;
  Except
	  On E : Exception do
	  Begin
		  Result := False;
		  pMensagensErro(E.Message, '[fAbrirTabela]');
	  End;
  End;
end;

function fFecharTabela(NomeTabela:TUniQuery):Boolean;
begin
  Try
	  If NomeTabela.Active = True Then NomeTabela.Close;
	  Result := True;
  Except
	  On E : Exception do
	  Begin
		  Result := False;
		  pMensagensErro(E.Message, '[fFecharTabela]');
	  End;
  End;
end;

{**************************************}
{* CRIA UMA QUERYNOVA PARA SER USADA  *}
{* PS. ATE QUE ENFIM ALGUEM FEZ ISSO  *}
{***********************************AF*}
function fCriaQuery(AOwner: TComponent = Nil): TUniQuery;
Begin

  Result := TUniQuery.Create(AOwner);
  Result.RequestLive := True;
  Result.Connection  := frmModulo.Database;

End;

Function fRetEmpresaFisica: String;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      SQL.Text := 'SELECT PRO_CODEMP WHERE PRO_NOMARQ = "MOVGER"';
      Open;

      If IsEmpty Then
        Result := VS_strCodEmp
      Else
        Result := FieldByName('PRO_CODEMP').AsString;

      Close;

    End;
    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := VS_strCodEmp;
      pMensagensErro(E.Message, '[fRetEmpresaFisica]');
    End;
  End;
End;

end.
