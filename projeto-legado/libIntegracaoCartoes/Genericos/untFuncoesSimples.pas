unit untFuncoesSimples;

interface

Uses
  Vcl.Controls,StrUtils,untConstantes,MadExcept,Forms,Winapi.Windows,Vcl.StdCtrls,Winapi.Messages,
  untIDataset,untTypesDLLCartao,DateUtils,SysUtils,System.Classes,untGetMenu,
  Vcl.Graphics,untMensagem,Vcl.Dialogs,BitBtnLockedIncrem,IdHashMessageDigest,Vcl.DBCtrls,
  cxCheckComboBox,Vcl.Mask,cxDropDownEdit,cxCalendar,System.JSON,cxProgressBar,
  REST.Json,Vcl.Themes, Vcl.Styles,Vcl.SysStyles,System.UITypes,Uni,Data.DB,UniClientDataSet,
  System.Math, ComCtrls, untTelasAbertas, untIIntegracaoCartoes, Menus;

Type
  EDumpStackTrace = class(Exception);


  function fParseError(strErrorMessage: String; Var strInfoAdicional: String): Integer;
  function AguardeExecutarModalA(const prcGen: TGenericProcedure;
                                 const strTexto, strChave: string): Boolean;

  procedure ExecutaAguarde(AFuncao: TFunctionFormGravando; AMensagem : String);
  function RetornaReplaceTabela(ATabela: String; ACamposIgnorados: Array of String): String;
  function fFloatToInt(fltNumero: Double): Integer;
  function fGetLetraAlfa(intCol: Integer): String;
  function fRetNomBandeira(strNumCar: String;ATipoCartao: String = ''): String;
  procedure pStep(pgbStatus: TcxProgressBar); Overload;
  procedure pStep(pgbStatus: TProgressBar); Overload;
  procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
  procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String='');
  function fSimpleRoundToEX(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;
  function fGetConnectionID: String;
  function fNomeArquivoValido(const ATexto: string): string;
  procedure pGravaLogErrArquivoLocal(const strErro, strStack, strLocal: String);
  procedure pErro(Mensagem:String);
  function fRetHoraServidor: TTime;
  function fRetDataServidor: TDate;
  procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');
  function fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
  function fRetornaStack: String;
  function fPosicoes(strString: String; chrBusca: Char): TIntArray;
  function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;
  function fVerificaAcessoSistema(strNomForm: String; strCodOpe: String = ''): Boolean;
  function fEhAdministrador(strCodOpe: String): Boolean; inline;
  function GetMD5(const strTexto: string): string;
  function fKeyIsDown(const Key: integer): boolean;
  function RetornaCampoDecimalJSON(AValor: String): String;
  procedure Aguarde(msecs: Integer);
  procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  function fNow: TDateTime;
  function RetornaTimeStampEmMilisegundos: Int64;
  function PrettyJSON(jsonstring:String):String;
  function PegaTimeZone: Integer;
  function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
  function fGetMenu(strTitulo: String; arrOpcoes: Array Of String; intOpcao: Integer;
                    blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False; intWidth: Integer = 0): Integer;
  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True;
                               blnTiraAbreviacaoNumero: Boolean = False;
                               strCaracterePersonalizado: String = ''): String;

  function fCriaClientDatset(qryOrigem: TDataset; blnVazio: Boolean = False;
   AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False; arrAddFields: TArray<TField> = Nil; arrSizeFields: TArray<TRecSizeField> = Nil): TUniClientDataSet;
  procedure pSetaClient(cdsClient: TDataSet);
  function fCriaDataSource(DataSet: TDataSet): TDataSource;
  function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  function fArredondaABNT_NBR5891_77(fltValor: Double;intDecimais: TRoundToRange; const Delta: Double  = 0.00001 ): Double;
  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
  function RetornadoEstabelecimentoSelecionado(AEstabelecimentos:String):String;
  function RetornaNomeEmpresaEstabelecimento(ACodEmp: String): String;
  function RetiraZerosEsquerda(AString: String): String;
  function fRetCGCEmpresa(strCodEmp: String): String;
  function fRetNomeEmpresa(strCodEmp: String): String;
  procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);

  procedure pIniciaVariaveisGlobais(AEmpresaLogada: String;
                                    AUsuarioLogado: String;
                                    AStyleAutcom: String;
                                    AModoClassico: Boolean;
                                    ANewGravando: Boolean;
                                    ACorTelaAguarde: TColor) StdCall;

  procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;

  Function fMensagem(strTitulo: String;
                     strTexto: String;
                     arrOpcoes: Array Of String;
                     intFocoBotao: Integer = 1;
                     blnSaiComEsc: Boolean = False;
                     intEstFon: Integer = 1;
                     intWidBut: Integer = 0;
                     blnAutosize: Boolean = False;
                     intSomarTop: Integer=0;
                     blnObrigaEsc: Boolean = False;
                     blnOcultPainelBtn: Boolean = False;
                     blnBtnSemImg : Boolean = False;
                     intHeightOpc: Integer = 0;
                     intFormWidth : Integer = 0;
                     intQtdLinha: Integer = -1;
                     pProcedureAjuda: TProcedureAjuda = nil): Integer; overload; //deprecated;


  Function fMensagemEx(strTitulo: String;
                       strTexto: String;
                       arrOpcoes: Array Of String;
                       intFocoBotao: Integer = 1;
                       blnSaiComEsc: Boolean = False;
                       intEstFon: Integer = 1;
                       intWidBut: Integer = 0;
                       blnAutosize: Boolean = False;
                       intSomarTop: Integer=0;
                       blnObrigaEsc: Boolean = False;
                       blnOcultPainelBtn: Boolean = False;
                       blnBtnSemImg : Boolean = False;
                       intHeightOpc: Integer = 0;
                       intFormWidth : Integer = 0;
                       intQtdLinha: Integer = -1): Integer;

  function GetParamValue(AParamID: String): String;
  function HasParam(AParamID: String): Boolean;

implementation

Uses untGravando,untNewgravando,untFuncoes;

function fRetCGCEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: IDataset;
begin
  Try

    qryGenEmp := objFunctions.fGetDataSet;

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  EMP_C_G_C_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryGenEmp.Close;
    qryGenEmp.SQL := strSQL;
    qryGenEmp.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenEmp.Open;
    Result := qryGenEmp.FieldByName('EMP_C_G_C_').AsString;
    qryGenEmp.Close;

  Finally
    qryGenEmp := Nil;
  End;

End;

function fRetNomeEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: IDataset;
begin
  Try

    qryGenEmp := objFunctions.fGetDataSet;

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  EMP_NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryGenEmp.Close;
    qryGenEmp.SQL := strSQL;
    qryGenEmp.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenEmp.Open;
    Result := qryGenEmp.FieldByName('EMP_NOMEMP').AsString;
    qryGenEmp.Close;

  Finally
    qryGenEmp := Nil;
  End;

End;

Function fMensagem(strTitulo: String;
                   strTexto: String;
                   arrOpcoes: Array Of String;
                   intFocoBotao: Integer = 1;
                   blnSaiComEsc: Boolean = False;
                   intEstFon: Integer = 1;
                   intWidBut: Integer = 0;
                   blnAutosize: Boolean = False;
                   intSomarTop: Integer=0;
                   blnObrigaEsc: Boolean = False;
                   blnOcultPainelBtn: Boolean = False;
                   blnBtnSemImg : Boolean = False;
                   intHeightOpc: Integer = 0;
                   intFormWidth: Integer = 0;
                   intQtdLinha: Integer = -1;
                   pProcedureAjuda: TProcedureAjuda = nil): Integer;
begin
  result := fMensagemEx(strTitulo,
                        strTexto,
                        arrOpcoes,
                        intFocoBotao,
                        blnSaiComEsc,
                        intEstFon,
                        intWidBut,
                        blnAutosize,
                        intSomarTop,
                        blnObrigaEsc,
                        blnOcultPainelBtn,
                        blnBtnSemImg,
                        intHeightOpc,
                        intFormWidth,
                        intQtdLinha);
end;


Function fMensagemEx(strTitulo: String;
                     strTexto: String;
                     arrOpcoes: Array Of String;
                     intFocoBotao: Integer = 1;
                     blnSaiComEsc: Boolean = False;
                     intEstFon: Integer = 1;
                     intWidBut: Integer = 0;
                     blnAutosize: Boolean = False;
                     intSomarTop: Integer=0;
                     blnObrigaEsc: Boolean = False;
                     blnOcultPainelBtn: Boolean = False;
                     blnBtnSemImg : Boolean = False;
                     intHeightOpc: Integer = 0;
                     intFormWidth: Integer = 0;
                     intQtdLinha: Integer = -1): Integer;
  Var
    intQtdOpcoes : Integer;
    intPosicao   : Integer;
    fntFonte     : TFont;
    frmMsg       : TfrmMensagem;
    aHandle      : THandle;
    wrdTexto     : Word;
    BtnHeight    : Integer;
begin
  BtnHeight      := 28;
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

  Try

    pCriarFormularios(TfrmMensagem, frmMsg);

    With frmMsg Do
    Begin
      intSomaTop := intSomarTop;
      If (blnAutosize) Then
        WindowState := wsMaximized;

      If intHeightOpc <> 0 Then
        frmMsg.Height := intHeightOpc;

      If ( (ParamCount = 1) And  SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA') ) Then
        blnAutosize := True;
        //intWidBut := 90;

      If strTitulo = '' Then
        strTitulo := 'AVISO';

      If intEstFon = 2 Then
        lblMensagem.Font.Name := 'Courier New';

      If SameText(ParamStr(1), 'VENDA_ASSISTIDA') Then
      Begin
        Height := 300;
        lblMensagem.Font.Size := 20;
        fntFonte.Size  := 18;
        frmMsg.lblTitulo.Font.Size := 18;
        frmMsg.pnlBotoes.Height := 60;
        BtnHeight := 50;
      End;

      lblTitulo.Caption   := strTitulo;
      lblMensagem.Caption := strTexto;

      If intQtdLinha > 0 Then
        frmMsg.Height := frmMsg.Height + (lblMensagem.Canvas.TextHeight('X') * intQtdLinha);

      if intFormWidth > 0 Then
        Width := intFormWidth;

      If intQtdOpcoes = 1 Then
      Begin
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 126
          Else
            Width      := intWidBut;

          If blnAutosize Then
          Begin
            Left  := (Screen.Width - 126) Div 2
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := 156 - ((intWidBut - 156) Div 2)
            Else
              If Length(arrOpcoes) = 1 Then
                Left       := (frmMsg.Width - Width) Div 2
              Else
              Left       := 156;
          End;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 2 Then
      Begin
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin
            Left  := ((Screen.Width - 2*130) Div 2);
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := ((frmMsg.Width - (intWidBut*2)) Div 2)
            Else
              Left       := 90;
          End;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin

            Left  := ((Screen.Width - 2*126) Div 2) + 126 + 7;

          End Else
          Begin

            If intWidBut <> 0 Then
              Left := ((frmMsg.Width - (intWidBut*2) ) Div 2) + intWidBut + 1
            Else
            Left       := 222;
          End;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 3 Then
      Begin

        if intFormWidth = 0 Then
        frmMsg.Width := 494;

        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3)
          Else
          Left       := 18;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3) + intWidBut + 1
          Else
          Left       := 166;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3) + (intWidBut * 2) + 1
          Else
          Left       := 314;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          If not blnBtnSemImg Then
            Glyph      := imgbotao3.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End;
    End;

    frmMsg.intFocus     := intFocoBotao;
    frmMsg.blnSaiComEsc := blnSaiComEsc;
    frmMsg.blnObrigaEsc := blnObrigaEsc;
    frmMsg.blnOcultPainelBtn := blnOcultPainelBtn;

   Try
     {$IFDEF TESTABILIDADE_AUTCOM}
     TTestabilidade.fGetTestabilidade.SetConteudoMensagem(strTexto);
     {$ENDIF}
   Except
     //
   End;

   frmMsg.ShowModal;
   Result := frmMsg.intRetorno;

   Try
    {$IFDEF TESTABILIDADE_AUTCOM}
     TTestabilidade.fGetTestabilidade.SetConteudoMensagem('');
     {$ENDIF}
   Except
     //
   End;

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[fMensagem]');
    End;
  End;

  FreeAndNil(frmMsg);
  FreeAndNil(fntFonte);

end;

function fRetornaStack: String;
begin
{$IFDEF LINUX}
  Result := EmptyStr;
{$ELSE}
  Try
    Raise EDumpStackTrace.Create(EDumpStackTrace.ClassName);
  Except
    On E: Exception Do
      Result := E.StackTrace;
  End;
{$ENDIF}
end;

function fTiraCaracEspeciais(strTexto      : String;
                             blnUsaLista   : Boolean = True;
                             blnTiraEspacos: Boolean = False;
                             blnTiraPontos : Boolean = False;
                             blnTiraDoisPts: Boolean = False;
                             blnTiraTab    : Boolean = False;
                             blnTiraVirgula: Boolean = True;
                             blnTiraAbreviacaoNumero: Boolean = False;
                             strCaracterePersonalizado: String = ''): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢Ø'
  Else
    strLista := EmptyStr;

  If (blnTiraEspacos) Then
    strLista := strLista + ' ';

  If (blnTiraPontos) Then
    strLista := strLista + '.';

  If (blnTiraDoisPts) Then
    strLista := strLista + ':';

  If (blnTiraTab) Then
    strLista := strLista + #9;

  If (blnTiraAbreviacaoNumero) Then
    strLista := strLista + 'º°';

  If (Not fEmptyStr(strCaracterePersonalizado)) Then
    strLista := strLista + strCaracterePersonalizado;

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function RetornaNomeEmpresaEstabelecimento(ACodEmp: String): String;
  Var
    qryDados: IDataset;
Begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := 'SELECT                                                                                '+
                  '  CONCAT(EMP_CODEMP,"-",EMP_NOMEMP) AS EMPRESA                                        '+
                  'FROM                                                                                  '+
                  '  CFGSIS                                                                              '+
                  '  JOIN CADEMP                                                                         '+
                  '    ON EMP_CODEMP = SIS_CODEMP                                                        '+
                  'WHERE SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO")                                      '+
                  '  AND IFNULL(SIS_VALCFG, "") <> ""                                                    '+
                  '  AND LOCATE(TRIM(LEADING 0 FROM :CODEMP),TRIM(LEADING 0 FROM SIS_VALCFG) ) > 0       ';

  qryDados.ParamByName('CODEMP').AsString := ACodEmp;
  qryDados.Open;

  If (qryDados.IsEmpty) Then
    Exit('');

  Result := qryDados.FieldByName('EMPRESA').AsString;
End;

function RetiraZerosEsquerda(AString: String): String;
begin

  While AString[1] = '0' do
    Delete(AString,1,1);

  Result := AString;
end;

function RetornadoEstabelecimentoSelecionado(AEstabelecimentos:String):String;
  Var
    LEstabelecimento: String;

    LListaEstab: TStringList;
    LContador: Integer;
    arrEstabelecimentos  : TStringArray;
    LSelecionado: Integer;
begin

  LListaEstab := TStringList.Create;
  LListaEstab.Delimiter := ',';
  LListaEstab.StrictDelimiter := True;
  LListaEstab.DelimitedText := AEstabelecimentos;
  LContador := 0;

  For LEstabelecimento In LListaEstab Do
  Begin
    SetLength(arrEstabelecimentos, Length(arrEstabelecimentos)+1);
    arrEstabelecimentos[LContador] :=LEstabelecimento;
    Inc(LContador);
  End;

  If (Length(arrEstabelecimentos) > 1) Then
  Begin
    LSelecionado := fGetMenu('Selecione o estabelecimento', arrEstabelecimentos, 0, True);

    If LSelecionado <> -1 Then
    Begin
      Result := arrEstabelecimentos[LSelecionado-1];
    End;
  End
  Else
    Result := AEstabelecimentos;

end;

function fGetMenu(strTitulo: String; arrOpcoes: Array Of String; intOpcao: Integer;
  blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False; intWidth: Integer = 0): Integer;
  Var
    intContador: Integer;
begin

  Result := -1;
  If (Not blnLibQtd) And (Length(arrOpcoes) <= 1) Then
  Begin
    fMensagem('', 'É Necessário escolher ao menos 2 opções', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmGetMenu, frmGetMenu);
    SetLength(frmGetMenu.arrOpcoes, Length(arrOpcoes));

    For intContador := 0 To Length(arrOpcoes)-1 Do
    Begin
      frmGetMenu.arrOpcoes[intContador] := arrOpcoes[intContador];
    End;

    If intOpcao <= 0 Then
      intOpcao := 1;

    Dec(intOpcao);

    frmGetMenu.intLinha     := intOpcao;
    frmGetMenu.blnSaiComEsc := blnSaiComEsc;
    frmGetMenu.Caption      := strTitulo;

    If intWidth > 0 Then
    Begin
      frmGetMenu.Width         := frmGetMenu.Width + intWidth;
      frmGetMenu.stgMenu.Width := frmGetMenu.Width;
      frmGetMenu.stgMenu.DefaultColWidth := frmGetMenu.Width;
    End;

    frmGetMenu.showModal;

    If frmGetMenu.blnConfirma Then
    Begin
      Result := frmGetMenu.intLinha+1;
    End;

  Except
    On E: Exception Do
    Begin
      Result := -1;
      pMensagensErro(E.Message, '[untFuncoes.fGetMenu]');
    End;
  End;

  FreeAndNil(frmGetMenu);

end;

procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  Var
    intCont: Integer;
    strMsg: String;
Begin

  strMsg := '';

  For intCont := 0 To 4 Do
  Begin

    Try
      Application.CreateForm(Classe, frmForm);
      strMsg := '';
    Except
      On E: EAccessViolation Do
        Raise;

      On E: Exception Do
        strMsg := E.Message + ' ' + E.ClassName;
    End;

    If fEmptyStr(strMsg) Then
      Break;

    Application.ProcessMessages;
    Sleep(1500);

  End;

  If Not fEmptyStr(strMsg) Then
    Raise Exception.Create('Erro ao criar o formulário.' + #13 + strMsg);

End;

procedure pIniciaVariaveisGlobais(AEmpresaLogada: String;
                                  AUsuarioLogado: String;
                                  AStyleAutcom: String;
                                  AModoClassico: Boolean;
                                  ANewGravando: Boolean;
                                  ACorTelaAguarde: TColor);
Begin
  VS_strCodEmp                        := AEmpresaLogada;
  strLoginUsuarioLogado               := AUsuarioLogado;
  blnUsuarioLogadoUtilizaModoClassico := AModoClassico;
  AUTCOM_STYLE_NAME                   := AStyleAutcom;
  NewGravando                         := ANewGravando;
  VS_Date                             := fRetDataServidor;

  Try
    COR_ZEBRA := StrToInt(fRetornaValorConfiguracao('CFG_CORZEB', VS_strCodEmp));
  Except
    COR_ZEBRA := clWhite;
  End;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    Try
      TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);
      TStyleManager.SystemHooks  := TStyleManager.SystemHooks - [shDialogs];

      TfrmNewGravando.CorPadraoTema := ACorTelaAguarde;

      TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Label', TSysComboBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Shape', TSysStaticStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
    Except
      blnUsuarioLogadoUtilizaModoClassico := True;
    End;
  End;
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: ITelasAbertas); StdCall;
begin
  untTelasAbertas.objTelasAbertas := ATelaAbertas;
end;

function fKeyIsDown(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

function fPosicoes(strString: String; chrBusca: Char): TIntArray;
  Var
    intContador: Integer;
begin

  For intContador := 1 To Length(strString) Do
  Begin
    If strString[intContador] = chrBusca Then
    Begin
      SetLength(Result, Length(Result)+1);
      Result[Length(Result)-1] := intContador;
    End
  End;

end;

procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
begin
  If Not Assigned(SenderUnico) Then
    Exit;

  If ((GetKeyState(VK_SHIFT) And 128) = 128) And
     ((GetKeyState(VK_TAB) And 128) = 128) Then
    Exit;

  Try
    if Form = Nil then
      Form := GetParentForm(SenderUnico);

    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;

        if (SenderUnico is TCustomCheckBox) or (SenderUnico is TCustomCombo) then
          SenderUnico.Perform(WM_UPDATEUISTATE, MakeWParam(UIS_CLEAR, UISF_HIDEFOCUS), 0);

      Except

      End;
    End;
  Except

  End;
end;

{*************************************************}
{*   Grava Mensagens de Erro no Arquivo de LOG   *}
{**********************************************DV*}
procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String='');
  Var
    qryLogErr: IDataSet;
begin
  If GravarErro Then
  Begin

    qryLogErr := objFunctions.fGetDataSet;
    qryLogErr.SQL := 'INSERT INTO LOGERR (  '+
                     '   LOG_CODEMP,        '+
                     '   LOG_LOGOPE,        '+
                     '   LOG_DTAERR,        '+
                     '   LOG_HORERR,        '+
                     '   LOG_DESCRI,        '+
                     '   LOG_RELERR         '+
                     ' )                    '+
                     ' VALUES               '+
                     '   (                  '+
                     '     :CODEMP,          '+
                     '     :LOGOPE,          '+
                     '     :DTAERR,          '+
                     '     :HORERR,          '+
                     '     :DESCRI,          '+
                     '     :RELERR           '+
                     '   )                  ';

    qryLogErr.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryLogErr.ParamByName('LOGOPE').AsString   := strLoginUsuarioLogado;
    qryLogErr.ParamByName('DTAERR').AsDateTime := Date;
    qryLogErr.ParamByName('HORERR').AsDateTime := fTime();
    qryLogErr.ParamByName('DESCRI').AsString   := MensagemErro;
    qryLogErr.ParamByName('RELERR').AsString   := fRetornaStack + strRelatorio;

    qryLogErr.ExecSQL;
    qryLogErr.Close;
  End;
end;

{****************************************}
{*   Exibe Mensagens de Erro do Banco   *}
{*************************************DV*}
procedure pErro(Mensagem:String);
begin
  HandleException;
end;

{*******************************************}
{*   Verifica Mensagens de Erro do Banco   *}
{****************************************DV*}
procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');
  Var
    NrErro: Integer;
    strInfo: String;
begin
  NrErro := fParseError(MensErro, strInfo);

  Case NrErro Of
    ERR_UNKNOW_ERROR         :pErro(MensErro + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_UNKNOW_DATABASE      :pErro(strInfo + ': Banco de dados inexistente' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ACCESS_DENIED        :pErro('Accesso negado ao usuário ' + strInfo + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_NOT_EXIST      :pErro('Tabela ' + strInfo + ' não Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_FOUND      :pErro('Campo ' + strInfo + ' não Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_READONLY       :pErro('Operação não suportada no modo Somente Leitura!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_INT        :pErro(strInfo + ' não é um número inteiro válido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_DATE       :fMensagem('ATENÇÃO!',strInfo + ' não é uma data válida!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem, ['&OK']);
    ERR_NOT_VALID_FLOAT      :pErro(strInfo + ' não é um número válido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_IN_EDIT          :pErro('Tabela não está em modo de Edição!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_SQL_SYNTAX           :pErro('Há um erro de Sintaxe no SQL: ' + strInfo + #10 + 'Local: ' + #10 + LocalErro + #10 + strMensagem);
    ERR_BD_NOT_ACTIVE        :pErro('O Servidor de banco de dados não está ativo!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_NULL       :pErro('O campo ' + strInfo + ' é de preenchimento obrigatório!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_PRIMARY_KEY          :pErro(strInfo + ': valor duplicado não permitido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ORDER_BY             :pErro('Coluna ' + strInfo + ' desconhecida no processo de ordenação!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERROR_FOREIGN_KEY_DELETE :begin
                                pGravarErro(True, '[ERROR_FOREIGN_KEY_DELETE] - Não é possível excluir esse registro', MensErro + sLineBreak);
                                fMensagem('ATENÇÃO!', 'Não é possível excluir esse registro, pois existe movimentação para o mesmo.', ['&O k']);
                              end;
    ERR_DEFAULT_PRINTER      :fMensagem('ATENÇÃO!', 'Não há impressora padrão selecionada!', ['&O k']);
  End;

  pGravarErro(True, MensErro + ' - ' + LocalErro);

end;

{*******************************************}
{* ANALISA A MENSAGEM DE ERRO E RETORNA UM *}
{* CÓDIGO DE ERRO CORRESPONDENTE           *}
{****************************************MV*}
function fParseError(strErrorMessage: String; Var strInfoAdicional: String): Integer;
  Var
    arrPosicoes: TIntArray;
begin

  arrPosicoes := fPosicoes(strErrorMessage, #39);

  If (Pos('Unknown database', strErrorMessage) > 0) Then
  Begin
    Result := ERR_UNKNOW_DATABASE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1] - arrPosicoes[0]);
  End
  Else If (Pos('Access denied for user', strErrorMessage) > 0) Then
  Begin
    Result := ERR_ACCESS_DENIED;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[1], arrPosicoes[3] - arrPosicoes[1]);
  End
  Else If (Pos('Table', strErrorMessage) > 0) And (Pos('doesn'#39't exist', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_NOT_EXIST;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If ((Pos('Field', strErrorMessage) > 0) And (Pos('not found', strErrorMessage) > 0)) OR
          ((Pos('Coluna', strErrorMessage) > 0) And (Pos('desconhecida', strErrorMessage) > 0)) Then
  Begin
    Result := ERR_FIELD_NOT_FOUND;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Operation is not allowed in READ ONLY mode', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_READONLY;
  End
  Else If (Pos('Cannot modify a read-only dataset', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_READONLY;
  End
  Else If (Pos('not a valid integer value', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_INT;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('not a valid date', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_DATE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('not a valid floating point value', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_FLOAT;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Dataset not in edit or insert mode', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_IN_EDIT;
  End
  Else If (Pos('You have an error in your SQL syntax', strErrorMessage) > 0) Then
  Begin
    Result := ERR_SQL_SYNTAX;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Can'#39't connect to local MySQL server through socket', strErrorMessage) > 0) Then
  Begin
    Result := ERR_BD_NOT_ACTIVE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Column', strErrorMessage) > 0) And (Pos('cannot be null', strErrorMessage) > 0) Then
  Begin
    Result := ERR_FIELD_NOT_NULL;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Duplicate entry', strErrorMessage) > 0 ) And (Pos('for key', strErrorMessage) > 0) Then
  Begin
    Result := ERR_PRIMARY_KEY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('duplicado', strErrorMessage) > 0 ) Or (Pos('duplicate', strErrorMessage) > 0) Then
  Begin
    Result := ERR_PRIMARY_KEY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Unknown column', strErrorMessage) > 0) And (Pos('order clause', strErrorMessage) > 0) Then
  Begin
    Result := ERR_ORDER_BY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('There is no default printer currently selected', strErrorMessage) > 0) Then
  Begin
    Result := ERR_DEFAULT_PRINTER;
    strInfoAdicional := '';
  End
//#################################################
  Else If (Pos('linha pai', strErrorMessage) > 0) And (Pos('chave estrangeira', strErrorMessage) > 0) Then
  Begin
    Result := ERROR_FOREIGN_KEY_DELETE;
    strInfoAdicional := '';
  End
  Else If (Pos('parent row', strErrorMessage) > 0) And (Pos('foreign key', strErrorMessage) > 0) Then
  Begin
    Result := ERROR_FOREIGN_KEY_DELETE;
    strInfoAdicional := '';
  End
//#################################################
  Else
    Result := ERR_UNKNOW_ERROR;
end;

{************************************}
{* TRANSFORMA STRING PARA DOUBLE    *}
{* QUANDO USAVA (S)TRTOFLOAT EM UM     *}
{* VALOR DE MILHAR EX 1.005,23      *}
{* OCORRIA ERRO POR CAUSA DO .      *}
{*********************************AF*}
function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
Begin
  strValorUnico := AnsiReplaceStr(strValorUnico,'%','');
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),fltDefault);
End;

procedure Aguarde(msecs: Integer);
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;


function fRetHoraServidor: TTime;
var
  qryCons: IDataset;
begin
  Result := 0;
  qryCons :=  objFunctions.fGetDataset;

  Try

    qryCons.SQL := 'SELECT CURRENT_TIME';
    qryCons.Open;

    Result := StrToTime(qryCons.FieldByName('CURRENT_TIME').AsString);

  Finally
    If Result = 0 Then
      Result := fTime();
  End;
end;


function RetornaTimeStampEmMilisegundos: Int64;
  var
    LDateTime: TDateTime;

    LDataServidor,
    LHoraServidor: TDateTime;

    LConsulta: IDataset;

    SystemTime: TSystemTime;
begin
  //Modificada a rotina anterior do Roni, para poder enviar a Data/Hora do servidor
  Try
    LConsulta := objFunctions.fGetDataset;

    LConsulta.SQL := 'SELECT CURRENT_DATE AS DATA, ' +
                     '       CURTIME(3) AS HORA ' +
                     'FROM DUAL';
    LConsulta.Open;

    LDataServidor := FloatToDateTime(LConsulta.FieldByName('DATA').AsFloat);
    LHoraServidor := IncHour(FloatToDateTime(LConsulta.FieldByName('HORA').AsFloat), PegaTimeZone);

    LDateTime := EncodeDate(YearOf(LDataServidor), MonthOf(LDataServidor), DayOf(LDataServidor)) +
                 EncodeTime(HourOf(LHoraServidor), MinuteOf(LHoraServidor), SecondOf(LHoraServidor), MilliSecondOf(LHoraServidor));

    Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
  Except
    GetSystemTime(SystemTime);
    LDateTime := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay) +
                 EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
    Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
  End;
End;

function PegaTimeZone: Integer;
  Var
    TimeZone: TTimeZoneInformation;

    LTimeZoneServer: IDataset;

    LValorMaquinaLocal: Integer;
begin
  If VS_TimeZone <> 0 Then
    Exit(VS_TimeZone);

  Result := 3;
  Try
    Try
      GetTimeZoneInformation(TimeZone);

      LValorMaquinaLocal := TimeZone.Bias div 60;
    Except
      LValorMaquinaLocal := 3;
    End;

    Try
      LTimeZoneServer := objFunctions.fGetDataset;
      LTimeZoneServer.SQL := 'SHOW VARIABLES LIKE "%system_time_zone%"';
      LTimeZoneServer.Open;

      If Not LTimeZoneServer.IsEmpty Then
      Begin
        Result := LTimeZoneServer.FieldByName('value').AsInteger * -1;
        Exit;
      End;

      Result := LValorMaquinaLocal;
    Except
      Result := LValorMaquinaLocal;
    End;
  Finally
    VS_TimeZone := Result;
  End;
end;

function GetMD5(const strTexto: string): string;
  var
    idHash128: TIdHashMessageDigest5;
begin
  Try
    idHash128 := TIdHashMessageDigest5.Create;

    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    FreeAndNil(idHash128);
  End;
end;

function fNow: TDateTime;
begin
  Result := IIF(Trunc(Date) = 0, nOw(), Date + fTime());
end;

{*************************************************}
{* Habilita/Desabilita Edits da Tela de Cadastro *}
{**********************************************DV*}
procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);
	var
		intContador : Integer;
begin
  For intContador := 0 to (NomeForm.ComponentCount - 1) do
  Begin
    If NomeForm.Components[intContador].Tag = 50 Then
      Continue;

    If NomeForm.Components[intContador].ClassNameIs('TEditFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBEditFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TComboBoxFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TComboBoxFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TMaskEditFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBMemoFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TGroupBox') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCheckBox') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCustomEdit') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCustomComboBox') Then
    	If TCustomComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TCustomComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbLookUpControl') Then
    	If TDbLookUpControl(NomeForm.Components[intContador]).TabStop Then
	    	TDbLookUpControl(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbRadioGroup') Then
      If TDbRadioGroup(NomeForm.Components[intContador]).TabStop Then
    	  TDbRadioGroup(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbCheckBox') Then
    	If TDbCheckBox(NomeForm.Components[intContador]).TabStop Then
	    	TDbCheckBox(NomeForm.Components[intContador]).Enabled := Habilitar;

//    If NomeForm.Components[intContador].ClassNameIs('TcxDBCheckComboBox') Then
//    	If TcxDBCheckComboBox(NomeForm.Components[intContador]).TabStop Then
//	    	TcxDBCheckComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TcxCheckComboBox') Then
    	If TcxCheckComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TcxCheckComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBLookupComboBox') Then
    	If TDBLookupComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TDBLookupComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBRadioGroup') Then
    	If TDBLookupComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TDBLookupComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TMaskEdit') Then
    	If TMaskEdit(NomeForm.Components[intContador]).TabStop Then
	    	TMaskEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TcxComboBox') Then
    	If TcxComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TcxComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TcxDateEdit') Then
    	If TcxDateEdit(NomeForm.Components[intContador]).TabStop Then
	    	TcxDateEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

	End;
end;

function PrettyJSON(JsonString:String):String;
  Var
    Jdoc:TJSONObject;
begin
  Try
    Jdoc:=TJSONObject.ParseJSONValue(JsonString) as TJSONObject;
    result:= TJSON.Format(Jdoc);
  Finally
    FreeAndNil(Jdoc);
  End;
end;


function RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

{*****************************************}
{* VALIDA SE O PERIODO É VALIDO          *}
{**************************************MV*}
function fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
begin

  Result := True;
  {*****************************************}
  {* CASO A DATA INICIAL SEJA VAZIA, OK    *}
  {**************************************MV*}
  If Not fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
  Begin
    Try
      If StrToDate(strDtaFin) < StrToDate(strDtaIni) Then
      Begin
        Result := False;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;
  End;

end;

function fRetNomBandeira(strNumCar: String;
  ATipoCartao: String = ''): String;
begin
  //Visa
  If (LeftStr(strNumCar, 1) = '4') And
     (Length(strNumCar) In [13, 16, 19]) Then
    Result := 'VISA'
  Else
  //Master
  If ((Pos(LeftStr(strNumCar, 2), '51_52_53_54_55_') > 0) Or
      (Pos(LeftStr(strNumCar, 4), '2221_2720_2307_') > 0) And
      (Length(strNumCar) = 16)) Or
     (Pos(LeftStr(strNumCar, 4), '6036_') > 0) Then
  Begin
    Result := 'MASTERCARD';

    If ATipoCartao = 'DÉBITO' Then
      Result := 'MAESTRO';
  End
  Else
  //Banricompras
  If (LeftStr(strNumCar, 6) = '639664') Then
    Result := 'BANRICOMPAS'
  Else
  //VerdeCard
  If (LeftStr(strNumCar, 6) = '627894') Then
    Result := 'VERDECARD'
  Else
  //BanriCard
  If (LeftStr(strNumCar, 6) = '608718') Then
    Result := 'BANRICARD'
  else
  //Maestro
  If ((Pos(LeftStr(strNumCar, 2), '50_56_57_58_') > 0) Or (LeftStr(strNumCar, 1) = '6')) And
     (Length(strNumCar) = 16) Then
    Result := 'MAESTRO'
  Else
  //American Express
  If (Pos(LeftStr(strNumCar, 2), '34_37_') > 0) Then
    Result := 'AMERICAN EXPRESS'
  Else
  //Diners
  If (Pos(LeftStr(strNumCar, 3), '300_301_302_303_304_305_309_') > 0) Or
     (Pos(LeftStr(strNumCar, 2), '36_38_39') > 0) And
     (Length(strNumCar) In [14, 16, 17, 18, 19]) Then
    Result := 'DINERS'
  Else
  //Elo
  If (Pos(LeftStr(strNumCar, 4), '4011_4576_5067_') > 0) Or
     (Pos(LeftStr(strNumCar, 6), '636368_438935_504175_451416_636297_506699_') > 0) Then
    Result := 'ELO'
  Else
  //Hipercard
  If (Pos(LeftStr(strNumCar, 4), '3841_6062_') > 0) Then
    Result := 'HIPERCARD'
  Else
  //Aura
  If (LeftStr(strNumCar, 2) = '50') Then
    Result := 'AURA'
  Else
  //BANESCARD
  If (Pos('585988',strNumCar) > 0) Then
    Result := 'BANESCARD'

  //Não conhecido
  Else
  Begin
    Result := 'OUTROS';

    If Pos('PIX', strNumCar) > 0 Then
      Result := 'PIX'
    Else If Pos('BOLETO', strNumCar) > 0 Then
      Result := 'BOLETO';

  End;
end;

function AguardeExecutarModalA(const prcGen: TGenericProcedure;
                               const strTexto, strChave: string): Boolean;
Begin
  Result := True;

  If NewGravando Then
    TfrmNewGravando.fExecutarModalA(prcGen,strTexto, '')
  Else
    TfrmGravando.fExecutarModalA(prcGen,strTexto, '');
End;

procedure pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure pStep(pgbStatus: TProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure ExecutaAguarde(AFuncao: TFunctionFormGravando; AMensagem : String);
  Var
    LFormGravando: TfrmGravando;
    LFormNewGravando: TfrmNewGravando;
Begin

  If NewGravando Then
  Begin
    Try
      pCriarFormularios(TfrmNewGravando, LFormNewGravando);
      LFormNewGravando.fExecutarAcao := AFuncao;
      LFormNewGravando.lblGravando.Caption := AMensagem;
      LFormNewGravando.pgbStatus.Visible := True;
      LFormNewGravando.ShowModal;
    Finally
      FreeAndNil(LFormNewGravando);
    End;
  End
  Else
  Begin
    Try
      pCriarFormularios(TfrmGravando, LFormGravando);
      LFormGravando.fExecutarAcao := AFuncao;
      LFormGravando.lblGravando.Caption := AMensagem;
      LFormGravando.pgbStatus.Visible := True;
      LFormGravando.ShowModal;
    Finally
      FreeAndNil(LFormGravando);
    End;
  End;
End;

function fGetLetraAlfa(intCol: Integer): String;
  Var
    strLetra : String;
    intLetra1: Integer;
    intLetra2: Integer;
    fltValor : Double;
begin
  strLetra := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  If intCol > 26 Then
  Begin
    fltValor  := (intCol / 26);
    intLetra1 := fFloatToInt(fltValor - Frac(fltValor));
    intLetra2 := fFloatToInt(intcol Mod 26);

    If intLetra2 = 0 Then
    Begin
      Dec(intLetra1);
      intLetra2 := 26;
    End;

    Result    := strLetra[intLetra1] + strLetra[intLetra2];
  End
  Else
    Result   := strLetra[intCol];

end;

function fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;


{**********************************************************************}
{* CRIA UM CLIENTDATASET COM A MESMA ESTRUTURA E VALORES DE UMA QUERY *}
{*******************************************************************JC*}
function fCriaClientDatset(qryOrigem: TDataset; blnVazio: Boolean = False;
 AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False; arrAddFields: TArray<TField> = Nil; arrSizeFields: TArray<TRecSizeField> = Nil): TUniClientDataSet;
  Var
    intCont  : Integer;
    intIdx_  : Integer;
    intSize  : Integer;
    intRecno : Integer;
begin

  Result := TUniClientDataSet.Create(AOwner);

  For intCont := 0 To qryOrigem.Fields.Count -1 Do
  Begin
    intSize := qryOrigem.Fields[intCont].Size;

    If Assigned(arrSizeFields) Then
    Begin
      For intIdx_ := 0 To Length(arrSizeFields) -1 Do
      Begin
        If (qryOrigem.Fields[intCont].FieldName = arrSizeFields[intIdx_].Name) Then
          intSize := arrSizeFields[intIdx_].Size
      End;
    End;

    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := qryOrigem.Fields[intCont].FieldName;
      DataType := qryOrigem.Fields[intCont].DataType;
      Size     := intSize;
      Required := False;
    End;
  End;

  For intCont := 0 To Length(arrAddFields) -1 Do
    Result.FieldDefs.Add(arrAddFields[intCont].FieldName,
                         arrAddFields[intCont].DataType,
                         arrAddFields[intCont].Size,
                         False);

  Result.CreateDataSet;
  Result.Open;

  Result.LogChanges := False;

  If blnVazio Then
    Exit;

  With qryOrigem Do
  Begin
    intRecno := RecNo;
    DisableControls;

    If Not blnRegistroAtual Then
      First;

    While (Not Eof) Or blnRegistroAtual Do
    Begin
      Result.Append;

      For intCont := 0 To Fields.Count -1 Do
        Result.Fields[intCont].Value := Fields[intCont].Value;

      Result.Post;

      If blnRegistroAtual Then
        Break;

      Next;
    End;
    RecNo := intRecno;
    EnableControls;
  End;

end;

procedure pSetaClient(cdsClient: TDataSet);
  Var
    intContador: Integer;
Begin
  With cdsClient Do
  For intContador := 0 To Fields.Count - 1 Do
  Begin
    If Fields[intContador].ReadOnly Then
      Fields[intContador].ProviderFlags := Fields[intContador].ProviderFlags - [pfInWhere, pfInUpdate];
    Fields[intContador].ReadOnly := False;
    Fields[intContador].Required := False;
  End;
End;

function fCriaDataSource(DataSet: TDataSet): TDataSource;
begin
  Result := TDataSource.Create(DataSEt);
  Result.DataSet := DataSet;
end;


function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  Var
    intDig: Integer;
    strVal: String;
begin
  strVal := FloatToStr(fltNumero);

  {*******************************}
  {* SE O VALOR POSSUIR DECIMAIS *}
  {****************************JC*}
  If Pos(FormatSettings.DecimalSeparator, strVal) > 0 Then
  Begin
    intDig := Length(strVal) - Pos(FormatSettings.DecimalSeparator, strVal);

    {*********************************************************************************}
    {* SUBSTITUI O ULTIMO DIGITO DE "5" PARA "6" FORCANDO O ARREDONDAMENTO PARA CIMA *}
    {******************************************************************************JC*}
    If (intDig > 0) And (intDig > intDecimais) And (strVal[Length(strVal)] = '5') Then
    Begin
      strVal[Length(strVal)] := '6';
    End;
  End;

  {************************************************************}
  {* CONTINUA FORMATANDO IGUAL ERA COM A FUNCAO fFormataFloat *}
  {*********************************************************JC*}
  Result := fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12, intDecimais));
end;

{******************************************}
{* FORMATA UM NUMERO COM X CASAS DECIMAIS *}
{***************************************MV*}
function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  //Se usa SAT entao sempre usa regras de arredondamento ABNT NBR 5891/77
  If fRetornaValorConfiguracao('USASAT',VS_strCodEmp).Equals('S') Or
     fRetornaValorConfiguracao('RAABNT',VS_strCodEmp).Equals('S') Then
  Begin
    Result := fArredondaABNT_NBR5891_77(fltNumero, intDecimais);
  End
  Else
  Begin
    Result := fFormataFloatInterna(fltNumero, intDecimais);
  End;
end;

function fArredondaABNT_NBR5891_77(fltValor: Double;
  intDecimais: TRoundToRange; const Delta: Double  = 0.00001 ): Double;
var
   extPow, extUltimosNumeros, extValorPow : Extended;
   fltParteRestante: Double;
   intCalc, intFracCalc, intUltimoNumero, intValor : Int64;
   blnNegativo: Boolean;
Begin
   blnNegativo  := (fltValor < 0);

   extPow       := intpower(10, abs(intDecimais) );
   extValorPow  := abs(fltValor) / 10 ;
   intValor  := trunc(extValorPow);
   extUltimosNumeros := frac(extValorPow);

   extValorPow := fSimpleRoundToEX( extUltimosNumeros * 10 * extPow, -9) ; // SimpleRoundTo elimina dizimas ;
   IntCalc  := trunc( extValorPow );
   intFracCalc := trunc( frac( extValorPow ) * 100 );

   if (intFracCalc > 50) then
     Inc( IntCalc )

   else if (intFracCalc = 50) then
   begin
     intUltimoNumero := round( frac( IntCalc / 10) * 10);

     if odd(intUltimoNumero) then
       Inc( IntCalc )
     else
     begin
       fltParteRestante := frac( extValorPow * 10 ) ;

       if fltParteRestante > Delta then
         Inc( IntCalc );
     end ;
   end ;

   Result := ((intValor*10) + (IntCalc / extPow));

   if blnNegativo then
     Result := -Result;
end;

function fSimpleRoundToEX(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;
var
  LFactor: Extended;
begin
  LFactor := IntPower(10.0, ADigit);
  if AValue < 0 then
    Result := Int((AValue / LFactor) - 0.5) * LFactor
  else
    Result := Int((AValue / LFactor) + 0.5) * LFactor;
end;

function fGetConnectionID: String;
  Var
    qryAux: TUniQuery;
begin
  Try
    qryAux := untFuncoes.CriarQueryDLL;
    Try
      qryAux.SQL.Add('SELECT CONNECTION_ID()');
      qryAux.Open;
      Result := qryAux.Fields[0].AsString;
    Finally
      FreeAndNil(qryAux);
    End;
  Except
    Result := '';
  End;
end;

function fNomeArquivoValido(const ATexto: string): string;
const
  cnsNomesReser: array[0..21] of string = (
    'CON','PRN','AUX','NUL',
    'COM1','COM2','COM3','COM4','COM5','COM6','COM7','COM8','COM9',
    'LPT1','LPT2','LPT3','LPT4','LPT5','LPT6','LPT7','LPT8','LPT9'
  );
var
  intIdx: Integer;
begin
  Result := Trim(ATexto);

  for intIdx := Length(Result) downto 1 do
  begin
    if (Ord(Result[intIdx]) < 32) or
       CharInSet(Result[intIdx], ['\', '/', ':', '*', '?', '"', '<', '>', '|']) then
      Delete(Result, intIdx, 1);
  end;

  while (Result <> '') and CharInSet(Result[Length(Result)], [' ', '.']) do
    Delete(Result, Length(Result), 1);

  for intIdx := Low(cnsNomesReser) to High(cnsNomesReser) do
  begin
    if SameText(Result, cnsNomesReser[intIdx]) then
    begin
      Result := Result + '_';
      Break;
    end;
  end;

  if Result = '' then
    Result := 'ARQ';
end;

procedure pGravaLogErrArquivoLocal(const strErro, strStack, strLocal: String);
  Var
    LstrPatArq,
    LstrCodOpe,
    LstrCodEmp,
    LstrConId_,
    LstrNomDir,
    LstrNomArq: String;
    LdtaTimLog: TDateTime;
    LstlLog: TStringList;
begin
  Try
    LstrNomDir := ExtractFilePath(Application.ExeName) + 'temp\log\';

    If (Not DirectoryExists(LstrNomDir)) Then
      ForceDirectories(LstrNomDir);

    If (Not DirectoryExists(LstrNomDir)) Then
      Exit;

    LdtaTimLog := Date+Time; //USO DE Date+Time EM DETRIMENTO DE fNow() PARA EVITAR ACESSO AO BANCO
    LstrNomArq := fNomeArquivoValido(strLocal);

    Try
      If VS_LastConnID.IsEmpty Then
        VS_LastConnID := fGetConnectionID;
      If VS_LastConnID.IsEmpty Then
        VS_LastConnID := '0';
    Except
      VS_LastConnID := '0';
    End;

    LstrConId_ := VS_LastConnID;
    LstrCodEmp := VS_strCodEmp;
    LstrCodOpe := strLoginUsuarioLogado;

    LstrPatArq := LstrNomDir + FormatDateTime('yyyymmddhhnnsszzz', LdtaTimLog) + '_' + LstrCodEmp + '_' + LstrCodOpe + '_' + LstrNomArq + '.txt';

    LstlLog := TStringList.Create;
    Try
      LstlLog.Add(strErro);
      LstlLog.Add('');
      LstlLog.Add('Data/Hora....: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LdtaTimLog));
      LstlLog.Add('Empresa......: ' + LstrCodEmp);
      LstlLog.Add('Operador.....: ' + LstrCodOpe);
      LstlLog.Add('Connection ID: ' + LstrConId_);
      LstlLog.Add('');
      LstlLog.Add(strStack);
      LstlLog.SaveToFile(LstrPatArq);
    Finally
      FreeAndNil(LstlLog);
    End;
  Except
    //
  End;
end;

function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;
Begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
End;

function fRetDataServidor: TDate;
var
  qryCons: IDataset;
begin
  qryCons := objFunctions.fGetDataSet;
  Try
    With qryCons Do
    Begin
      Close;
      SQL := ('SELECT CURRENT_DATE');
      Open;

      Result := StrToDate(FieldByName('CURRENT_DATE').AsString);
    End;
  Finally
    qryCons := Nil;
  End;
end;

function GetParamValue(AParamID: String): String;
Var
  I: Integer;
begin
  Result := '';
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID, True) then
      exit(Copy(ParamStr(I), Length(AParamID) + 1, MaxInt));
end;

function HasParam(AParamID: String): Boolean;
Var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID, True) then
      exit(True);
end;

function fVerificaAcessoSistema(strNomForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
    strSQL     : String;
    qryGenOpe  : TUniQuery;

begin
  Try

    qryGenOpe := untFuncoes.CriarQueryDLL;

    If (Not fEmptyStr(strCodOpe)) Then
      strOperador := strCodOpe
    Else
      strOperador := strLoginUsuarioLogado;

    If (strNomForm = 'frmLogoff') Or (strNomForm = 'frmSobre') Or (strNomForm = 'frmUtilMenuPAFNFCe') Then
    Begin
      Result := True;
      exit;
    End;

    If Not fEhAdministrador(strOperador) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '   DIROPE ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '   OPE_CODOPE = :CODOPE AND ';
      strSQL := strSQL + '   DIR_NOMFRM = :NOMFRM ';
      Result := False;
      With qryGenOpe Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODOPE').AsString := strOperador;
        ParamByName('NOMFRM').AsString := strNomForm;
        Open;
        If Not IsEmpty Then
          Result := True;
      End;
      qryGenOpe.Close;
    End
    Else
      Result := True;

  Finally
    FreeAndNil(qryGenOpe);
  End;

end;

function fEhAdministrador(strCodOpe: String): Boolean;
Begin
  Result := SameText('999', strCodOpe) Or
            SameText('998', strCodOpe) Or
            SameText('997', strCodOpe);
End;


function RetornaReplaceTabela(ATabela: String; ACamposIgnorados: Array of String): String;
  Var
    LConsulta : TUniQuery;
    LCampo: TField;
    LCamposTabela: String;
    LParametrosTabela: String;
begin
  LConsulta := untFuncoes.CriarQueryDLL;

  Try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM '+ ATabela +' WHERE FALSE');
    LConsulta.Open;

    For LCampo In LConsulta.Fields Do
    Begin

      If MatchStr(LCampo.FieldName,ACamposIgnorados) Then
        Continue;

      LCamposTabela     := LCamposTabela + LCampo.FieldName + ',';
      LParametrosTabela := LParametrosTabela + ':' + LCampo.FieldName + ',';
    End;

    LCamposTabela     := LeftStr(LCamposTabela, LCamposTabela.Length - 1);
    LParametrosTabela := LeftStr(LParametrosTabela, LParametrosTabela.Length - 1);

    Result := 'REPLACE INTO '+ ATabela +' (' + LCamposTabela + ') ' +
                   ' VALUES (' + LParametrosTabela + ') ';
  Finally
    FreeAndNil(LConsulta);
  End;
end;

end.
