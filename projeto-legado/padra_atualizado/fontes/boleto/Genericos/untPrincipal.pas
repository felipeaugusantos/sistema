{************************************************************}
{*                                                          *}
{* PROGRAMA BOLETO.                                         *}
{* UTILIZADO PARA IMPRESSÃO DE BOLETOS DE COBRANÇA BANCÁRIA *}
{*                                                          *}
{*********************************************************ED*}
unit untPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, RXShell, Menus, Mask, ComCtrls, StrUtils,
  QColorLabel, EditFocus, rxToolEdit;



type
  TfrmPrincipal = class(TForm)
    timLerArquivo: TTimer;
    tryPrograma: TRxTrayIcon;
    PopupMenu1: TPopupMenu;
    mnuFechar: TMenuItem;
    mnuMosJanela: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    pathLocal: TDirectoryEdit;
    Panel2: TPanel;
    btnGravar: TBitBtn;
    btnSair: TBitBtn;
    Label2: TLabel;
    edtTipImp: TEditFocus;
    ColorLabel1: TColorLabel;
    StatusBar1: TStatusBar;
    pnlMenu: TPanel;
    trvBancos: TTreeView;
    memObserv: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure timLerArquivoTimer(Sender: TObject);
    procedure mnuFecharClick(Sender: TObject);
    procedure mnuMosJanelaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure trvBancosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);


    //*******************************************************//
    // ORIENTAÇÕES SOBRE O LAY-OUT DE UM BOLETO DE COBRANÇA  //
    //                                                       //
    //  TODO BOLETO DE COBRANÇA E FORMADO POR DUAS PARTES    //
    //  1 - PRIMEIRA PARTE CONSISTE E UMA NUMERAÇÃO DE 20    //
    //  CARACTERES QUE E A MESMA PARA TODOS OS BANCOS MUD-   //
    //  -ANDO APENAS O NÚMERO DO BANCO, AGÊNCIA, CÓD. CEDE-  //
    //  -NTE, NOSSO NUMERO, DÍGITOS VERIFICADORES E ETC.     //
    //                                                       //
    //  2 - SEGUNDA PARTE CONSISTE E UMA NUMERAÇÃO DE 25     //
    //  CARACTERES CHAMADA CAMPO LIVRE, E ESTA SIM É NA      //
    //  MAIORIA DAS VEZES DIFERENTE DE UM BANCO PARA O OUTRO //
    //                                                       //
    //  A QUANTIDADE TOTAL DE CARACTERES DE UM BOLETO E DE   //
    //  45 CARACTERES 20 - (PADRAO) E 25 - (CAMPO LIVRE).    //
    //                                                       //
    //  PARA RECEBIMENTO DO BOLETO PODER SER USADO A LINHA   //
    //  DIGITÁVEL OU O CÓDIGO DE BARRAS, QUE SÃO COMPOSTOS   //
    //  PELOS MESMOS NÚMEROS, PORÉM COM UMA DISPOSIÇÃO       //
    //  DIFERENTE                                            //
    //                                                       //
    //****************************************************ED*//
    
  private
    { Private declarations }
		strPatLoc   : String;
    strNomArq   : String;
    strTipImp   : String;
    blnFechar   : Boolean;

    //*************************************************//
    // PROCESSA OS DADOS E CALCULA OS DIGITOS          //
    //**********************************************ED*//
    procedure pProArq033; // BANESPA 033
    procedure pProArq353; // SANTANDER 353
    procedure pProArq033B;
    procedure pProArq021;
    procedure pProArq341; // ITAU 341
    procedure pProArq422; // SAFRA 422
    procedure pProArq748; // SICREDI 748
    procedure pProArq151; // NOSSA CAIXA 151


    //*************************************************//
    // PROCEDURES USADAS EM BOLETOS GENERICA           //
    //**********************************************ED*//
    function fProArquivo(strIdeBan: String): Boolean;
    function fImpCodBar(ClasseForm:TFormClass; frmNomFrm: TForm): Boolean;
    function fProcessarArquivo(strArquivo: String): Boolean;

  public
    { Public declarations }



  end;

var
  frmPrincipal: TfrmPrincipal;
Const
  SENHA_BOLETO = 'TIGRE3967';


implementation
  uses untFuncoes, untBoletoItau, untBoletoSafra, untBoletoNossaCaixa,
  untBoletoHsbc, untDesCam, untQckUnibanco, untBancos, untQckBradesco,
  untQckRibeiraoPreto, untQckCaixaE_F_J, untQckCaixaE_F_L, untQckBancoBrasil,
  untQckBanCoob, untQckSicredi, {untQckBancoSafra,} untQckBanespa,
  untQckBradesco_Pro, untQckBancoPadrao, untQckSantander, untBoletoItauPro,
  untQckSantanderBan, untQckBanestes;

{$R *.dfm}

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin

	blnFechar := True;
	strPatLoc := Trim( pathLocal.Text ) + '\';

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

  pathLocal.Text := fArqIni( 0, 'IMPRESSORA LASER', 'GERAL', 'PATH' );
  edtTipImp.Text := fArqIni( 0, 'IMPRESSORA LASER', 'TIPO IMPRESSORA', '' );

  strTipImp      := Trim(edtTipImp.Text);

  If Trim(strTipImp) = '' Then
    strTipImp := 'L';

  //*************************************************//
  // CHAMA NA TELA UM PREVIEW AO INVES DE IMPRIMIR   //
  // DIRETO NA IMPRESSPRA PADRAO                     //
  //**********************************************ED*//
  blnPegImp := fArqIni( 0, 'IMPRESSORA LASER', 'PERIMP', '' ) = 'S';

end;

procedure TfrmPrincipal.btnGravarClick(Sender: TObject);
begin
  fArqIni( 1, 'IMPRESSORA LASER', 'GERAL', pathLocal.Text );
  fArqIni( 1, 'IMPRESSORA LASER', 'TIPO IMPRESSORA', edtTipImp.Text);

end;

procedure TfrmPrincipal.timLerArquivoTimer(Sender: TObject);
	Var
    intContador  : Integer;
    lstListArq   : TStringList;
    intContador2 : TSearchRec;

begin

  timLerArquivo.Enabled := False;

  //*****************************************************//
  // CRIA UMA STRING LIST PARA ARMAZENAR O NOME DOS TXTS //
  //*****************************************************//
  lstListArq        := TStringList.Create;
  lstListArq.Sorted := True;


  //*****************************************************//
  // ATRIBUI A STRING LIST OS NOMES DE TODOS OS TXTS A   //
  // SEREM PROCESSADOS                                   //
  //*****************************************************//





  If (FindFirst( strPatLoc + '*.TXT', faArchive, intContador2 )=0) Then
  Begin
    Repeat
      lstListArq.Add(intContador2.Name);
    Until FindNext(intContador2)<>0;
  End;



  //******************************************************//
  // EXECUTA UM "FOR" NA STRING LIST, PROCESSANDO OS TXTS //
  //******************************************************//
  For intContador := 0 To lstListArq.Count -1 Do
  Begin

    strNomArq := Trim( lstListArq.Strings[intContador] );

    {****************************************}
    {*  FUNCAO QUE ABRE O ARQUIVO TXT       *}
    {* E PROCESSA OS DADOS CORRESPONDENTES  *}
    {*************************************ED*}
    fProcessarArquivo(strPatLoc + strNomArq);

    //*****************************************************//
    // APOS PROCESSAR O ARQUIVO DELETA O MESMO             //
    //*****************************************************//
    DeleteFile( strPatLoc + strNomArq );

  End;

  timLerArquivo.Enabled := True;

end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
  Var
    strSenha: String;
begin

  If (Not ffrmSenha(strSenha, 'Senha para Finalizar')) Then
  Begin
    Exit;
  End;

  If (AnsiUpperCase(strSenha) <> SENHA_BOLETO) Then
  Begin
    Exit;
  End;


	Close;

end;

procedure TfrmPrincipal.mnuMosJanelaClick(Sender: TObject);
  Var
    strSenha: String;
begin

  If (Not ffrmSenha(strSenha, 'Senha para Configurações')) Then
  Begin
    Exit;
  End;

  If (AnsiUpperCase(strSenha) <> SENHA_BOLETO) Then
  Begin
    Exit;
  End;

	Self.Show;

end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

	CanClose := ( Not Self.Visible );

  If ( Not CanClose ) Then
  	Self.Hide;

end;

procedure TfrmPrincipal.FormPaint(Sender: TObject);
begin

	If blnFechar Then
  Begin
		Self.Hide;
    blnFechar := False;
  End;

end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin

	Close;
  Self.Hide;

end;



{*************************************}
{* PROCESSAR ARQUIVO TXT NO FORMATO  *}
{* DO BANCO BANESPA SANTANDER        *}
{**********************************ED*}
procedure TfrmPrincipal.pProArq033;
begin

  {* FUNCAO QUE GERA A LINHA DIGITAVEL *}
  If Not( fGeLiDi033 ) Then
    Exit;


  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
               strCodCed + strNumDup + '00' + strIdeBan + strDigiL1 + strDigiL2;

  strCodBar := fGerar_String_Codigo_Barra(strCodBar);


  fImpCodBar( tfrmQckBanespa,  frmQckBanespa);

end;

{*************************************}
{* PROCESSAR ARQUIVO TXT NO FORMATO  *}
{* DO BANCO BANESPA SANTANDER        *}
{**********************************ED*}
procedure TfrmPrincipal.pProArq353;
begin

  {* FUNCAO QUE GERA A LINHA DIGITAVEL *}
  If Not( fGeLiDi353 ) Then
    Exit;


  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
               strCodCed + strNosNum + '00' + strIdeBan + strDigiL1 + strDigiL2;

  strCodBar := fGerar_String_Codigo_Barra(strCodBar);


  fImpCodBar( tfrmQckSantander,  frmQckSantander);

end;

{*************************************}
{* PROCESSAR ARQUIVO TXT NO FORMATO  *}
{* DO BANCO BANESPA SANTANDER 033    *}
{**********************************AF*}
procedure TfrmPrincipal.pProArq033B;
begin

  If Not( fGeLiDi033B ) Then
    Exit;

  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit + '9' +
               strCodCed + strNosNum + '0' + IIF(strCodCar = '4', '102', IIF(strCodCar = '6', '201', '101'));

  strCodBar := fGerar_String_Codigo_Barra(strCodBar);
  fImpCodBar(TfrmQckSantanderBan,  frmQckSantanderBan);
end;

{*************************************}
{* PROCESSAR ARQUIVO TXT NO FORMATO  *}
{* DO BANCO BANESTES                 *}
{**********************************AF*}
procedure TfrmPrincipal.pProArq021;
begin

  If Not( fGeLiDi021 ) Then
    Exit;

  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit + LeftStr(strNosNum, 8) + strCodCed +
               strCodCar + '021' + strDiAsb1 + strDiAsb2;

  strCodBar := fGerar_String_Codigo_Barra(strCodBar);
  fImpCodBar(TfrmQckBanestes,  frmQckBanestes);
end;


{******************************}
{* PROCESSAR ARQUIVO TXT NO   *}
{* FORMATO DO BANCO ITAÚ      *}
{***************************ED*}

procedure TfrmPrincipal.pProArq341;
begin

  If Not( fGeLiDi341 ) Then
    Exit;


  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
                strCodCar + strNosNum + strNumAge + strCodCed + '000';

  strCodBar := fGerar_String_Codigo_Barra(strCodBar);

  If Not( blnProEnt ) Then
    fImpCodBar(tfrmQckBoletoItau, frmQckBoletoItau)
  Else
    fImpCodBar(tfrmQckBoletoItauPro, frmQckBoletoItauPro);

end;


{*****************************************}
{* BANCO SAFRA 422                       *}
{**************************************AF*}
procedure TfrmPrincipal.pProArq422;
begin

  If Not fGeLiDi422 Then
    Exit;

  fImpCodBar( tfrmQckBoletoSafra,  frmQckBoletoSafra);
end;


{******************************}
{* PROCESSAR ARQUIVO TXT NO   *}
{* FORMATO DO BANCO SICREDI   *}
{***************************ED*}
procedure TfrmPrincipal.pProArq748;
begin

  {* FUNCAO QUE GERA A LINHA DIGITAVEL *}
  pGeLiDi748;
  

  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit +
               strCmpLiv;

  strCodBar := fGerar_String_Codigo_Barra(strCodBar);

  fImpCodBar(TfrmQckSicredi, frmQckSicredi);

end;

{********************************}
{* NOSSA CAIXA NOSSO BANCO      *}
{*****************************AF*}
procedure TfrmPrincipal.pProArq151;
begin
  pGeLiDi151;
     
  {*****************************************}
  {* GERANDO CODIGO DE BARRAS              *}
  {**************************************AF*}
  strCodBar := strIdeBan + strMoeda1 + strDiAuCo + strFatVen + strVlrTit + strCmpLiv;
  strCodBar := fGerar_String_Codigo_Barra(strCodBar);

  fImpCodBar(TfrmQckBoletoNossaCaixa, frmQckBoletoNossaCaixa);
end;

function TfrmPrincipal.fProArquivo(strIdeBan: String): Boolean;
  Var
    frmGeneri  : TForm;
    ClasseForm :TFormClass;

begin

  Result := True;

  //*************************************//
  //* FUNCAO QUE GERA A LINHA DIGITAVEL *//
  //*************************************//
  If strIdeBan = '001' Then
  Begin
    strEspDoc  := 'DM';
    Result     := fGeLiDi001;
    frmGeneri  := frmQckBancoBrasil;
    ClasseForm := tfrmQckBancoBrasil;
  End

  Else If strIdeBan = '237' Then
  Begin
    Result     := fGeLiDi237;

    If Not( blnProEnt ) Then
    Begin
      frmGeneri  := frmQckBradesco;
      ClasseForm := tfrmQckBradesco;
    End
    Else
    Begin
      frmGeneri  := frmQckBradesco_PRO;
      ClasseForm := tfrmQckBradesco_PRO;
    End;
  End

  Else If strIdeBan = '104' Then
  Begin
    Result     := fGeLiDi104;

    frmGeneri  := frmQckCaixaE_F_J;
    ClasseForm := tfrmQckCaixaE_F_J;
    If strTipImp = 'L' Then
    Begin
      frmGeneri  := frmQckCaixaE_F_L;
      ClasseForm := tfrmQckCaixaE_F_L;
    End;

  End

  Else If strIdeBan = '741' Then
  Begin
    Result     := fGeLiDi741;
    frmGeneri  := frmQckRibeiraoPreto;
    ClasseForm := tfrmQckRibeiraoPreto;
  End

  Else If strIdeBan = '353' Then
  Begin
    Result     := fGeLiDi353;
    frmGeneri  := frmQckSantander;
    ClasseForm := tfrmQckSantander;
  End

  Else If strIdeBan = '756' Then
  Begin
    Result     := fGeLiDi756;
    frmGeneri  := frmQckBanCoob;
    ClasseForm := tfrmQckBanCoob;
  End

  Else If strIdeBan = '409' Then
  Begin
    If (StrToIntDef(strCodCar, 0) = 20) Then
      Result := fGeLiDi409SemRegistro
    Else
      Result     := fGeLiDi409;
    frmGeneri  := frmQckUnibanco;
    ClasseForm := tfrmQckUnibanco;
  End

  Else If strIdeBan = '356' Then
  Begin
    Result     := fGeLiDi356;
    frmGeneri  := frmQckBancoPadrao;
    ClasseForm := tfrmQckBancoPadrao;
  End

  Else If strIdeBan = '399' Then
  Begin
    Result     := fGeLiDi399;
    frmGeneri  := frmQckBancoPadrao;
    ClasseForm := tfrmQckBancoPadrao;
  End

  Else If strIdeBan = '041' Then
  Begin
    Result     := fGeLiDi041;
    frmGeneri  := frmQckBancoPadrao;
    ClasseForm := tfrmQckBancoPadrao;
  End;



  //*************************************************//
  // FUNCAO QUE EFETIVAMENTE IMPRIME O BOLETO        //
  //**********************************************ED*//
  If ( Result ) Then
     fImpCodBar(ClasseForm, frmGeneri);


end;

function TfrmPrincipal.fImpCodBar(ClasseForm:TFormClass;frmNomFrm: TForm): Boolean;
begin

  Try
    Application.CreateForm(ClasseForm, frmNomFrm);
  Finally
    FreeAndNil(frmNomFrm);
  End;

end;


function TfrmPrincipal.fProcessarArquivo(strArquivo: String): Boolean;
  Var
    arqTexto  : TextFile;
    strLines  : String;
Begin

  AssignFile(arqTexto, strArquivo);
  Reset(arqTexto);

  While Not Eof(arqTexto) Do
  Begin
    Readln(arqTexto, strLines);

    strIdeBan := Trim(Copy(strLines, 001,03));       // IDENTIFICAÇÃO DO BANCO
    strTipIns := Trim(Copy(strLines, 004,02));       // TIPO DE INSCRIÇÃO 01/02 - CNPJ/CPF
    strNumIns := Trim(Copy(strLines, 006,14));       // NÚMERO DA INSCRIÇÃO DO CEDENTE
    strNomCed := Trim(Copy(strLines, 020,60));       // NOME DO CEDENTE
    strNumAge := Trim(Copy(strLines, 080,04));       // NÚMERO DA AGÊNCIA
    strCodCed := Trim(Copy(strLines, 084,20));       // CÓDIGO DO CEDENTE
    strNosNum := Trim(Copy(strLines, 104,15));       // NOSSO NÚMERO
    strNumDup := Trim(Copy(strLines, 107,07));       // NÚMERO DA DUPLICATA (SEM O DÍGITO)
    strNumDoc := Trim(Copy(strLines, 119,13));       // NÚMERO DO DOCUMENTO
    strEspDoc := Trim(Copy(strLines, 132,07));       // ESPÉCIE DO DOCUMENTO
    strCodCar := Trim(Copy(strLines, 175,03));       // CÓDIGO DA CARTEIRA
    strEspTit := Trim(Copy(strLines, 178,04));       // ESPÉCIE DO TITULO (R$)
    strIdeAce := Trim(Copy(strLines, 182,01));       // IDENTIFICAÇÃO ACEITE
    strTipISa := Trim(Copy(strLines, 213,02));       // TIPO DE INSCR. SACADO
    strNuInSa := Trim(Copy(strLines, 215,14));       // NÚMERO DA INSCR. SACADO
    strNomSac := Trim(Copy(strLines, 229,40));       // NOME DO SACADO
    strEndSac := Trim(Copy(strLines, 269,40));       // ENDEREÇO DO SACADO
    strBaiSac := Trim(Copy(strLines, 309,20));       // BAIRRO DO SACADO
    strCep001 := Trim(Copy(strLines, 329,08));       // CEP DO SACADO
    strCidSac := Trim(Copy(strLines, 337,40));       // CIDADE DO SACADO
    strEstSac := Trim(Copy(strLines, 377,02));       // UF DO SACADO
    strSacAva := Trim(Copy(strLines, 379,40));       // SACADO/AVALISTA
    strPraPro := Trim(Copy(strLines, 419,02));       // PRAZO PARA PROTESTO
    strLocPag := Trim(Copy(strLines, 421,60));       // LOCAL DE PAGAMENTO
    strUsoBan := Trim(Copy(strLines, 481,10));       // USO DO BANCO
    strInstr1 := Trim(Copy(strLines, 491,60));       // INSTRUÇÃO 1
    strInstr2 := Trim(Copy(strLines, 551,60));       // INSTRUÇÃO 2
    strInstr3 := Trim(Copy(strLines, 611,60));       // INSTRUÇÃO 3
    strInstr4 := Trim(Copy(strLines, 671,60));       // INSTRUÇÃO 4
    strInstr5 := Trim(Copy(strLines, 731,60));       // INSTRUÇÃO 5
    strNumCon := Trim(Copy(strLines, 791,07));       // NÚMERO DO CONVÊNIO
    strDigAge := Trim(Copy(strLines, 798,01));       // DÍGITO DA AGÊNCIA
    strCodCli := Trim(Copy(strLines, 799,08));       // CODIGO DO CLIENTE
    strModCob := Trim(Copy(strLines, 807,04));       // MODALIDADE DE COBRANCA
    blnProEnt := Trim(Copy(strLines, 825,01)) = 'S'; // IMPRIME PROTOCOLO DE ENTREGA
    strVariac := Trim(Copy(strLines, 832,03));       // VARIACAO
    strEndere := Trim(Copy(strLines, 849,160));      // ENDEREÇO COMPLETO DO CEDENTE
    strIdeCed := Trim(Copy(strLines,1009,006));      // IDENTIFICAÇÃO DO CEDENTE
    strUsoCli := Trim(Copy(strLines,1015,017));      // USO DO CLIENTE
    strDigCed := Trim(Copy(strLines,1032,002));      // DIGITO DO CEDENTE
    strTipDia := Trim(Copy(strLines,1034,001));      // TIPO DE DIAS PARA PROTESTO

    //************************************//
    // VALOR DA MULTA                     //
    //*********************************ED*//
    Try
      fltVlrMul := StrToCurr(Trim(Copy(strLines, 1035,12) + ',' +
                                  Copy(strLines, 1047,02)));
    Except
      fltVlrMul := 0;
    End;

    If fEmptyStr(Trim(strTipDia)) Then
      strTipDia := '1';

    fltDesBol := StrToCurr(Trim(Copy(strLines, 835,12) + ',' +
                                Copy(strLines, 847,02))); // DESCONTO PARA PAGAMENTO A VISTA

    If strIdeBan = '041' Then
    Begin
      strDigAge := Trim(Copy(strLines, 826,02));       // DÍGITO DA AGÊNCIA
      strCodCar := Trim(Copy(strLines, 828,04));       // CÓDIGO DA CARTEIRA
    End;

    //*****************************************************//
    // VERIFICA SE A VARIVEL COM O CODIGO DO CLIENTE ESTA  //
    // PREENCHIDA, SE ESTIVER ENTAO CONCATENA COM O NOME   //
    // DO SACADO (CLIENTE)                                 //
    //**************************************************ED*//
    If Trim(strCodCli) <> '' Then
    Begin
      strNomSac := Trim(strCodCli) + ' - ' + Trim(strNomSac);
    End;


    //************************************//
    // VALIDA A DATA DO VENCIMENTO        //
    //*********************************ED*//
    fValidaData('139 á 148 ', Copy(strLines, 139,02) +
                              Copy(strLines, 141,02) +
                              Copy(strLines, 143,04)
                            , 'Data de Vencimento');

    dtaDtaVen := StrToDate(Trim(Copy(strLines, 139,02) + '/' +
                                Copy(strLines, 141,02) + '/' +
                                Copy(strLines, 143,04)));

    //************************************//
    // VALIDA A DATA DA EMISSÃO           //
    //*********************************ED*//
    fValidaData('183 á 190 ', Copy(strLines, 183,02) +
                              Copy(strLines, 185,02) +
                              Copy(strLines, 187,04)
                            , 'Data de Emissão');

    dtaDtaEmi := StrToDate(Trim(Copy(strLines, 183,02) + '/' +
                                Copy(strLines, 185,02) + '/' +
                                Copy(strLines, 187,04)));

    //************************************//
    // VALIDA A DATA DO PROCESSAMENTO     //
    //*********************************ED*//
    fValidaData('181 á 188 ', Copy(strLines, 191,02) +
                              Copy(strLines, 193,02) +
                              Copy(strLines, 195,04)
                            , 'Data de Processamento');

    dtaDtaPro := StrToDate(Trim(Copy(strLines, 191,02) + '/' +
                                Copy(strLines, 193,02) + '/' +
                                Copy(strLines, 195,04)));

    //************************************//
    // VALOR DO TÍTULO                    //
    //*********************************ED*//
    strVlrTit := RightStr(Trim(Copy(strLines, 147,14)), 10);

    //******************************//
    // VALOR DO DESCONTO DO TÍTULO  //
    //***************************ED*//
    fltVlrDes := StrToCurr(Trim(Copy(strLines, 161,12) + ',' +
                                Copy(strLines, 173,02)));

    //************************************//
    // VALOR DA MORA                      //
    //*********************************ED*//
    fltVlrMor := StrToCurr(Trim(Copy(strLines, 199,12) + ',' +
                                Copy(strLines, 211,02)));

    //**************************************************//
    // MOEDA = 9 - INDICA QUE A COBRANÇA É EM REAIS R$  //
    //***********************************************ED*//
    strMoeda1 := '9';


    //*********************************************************************//
    //                                                                     //
    // FOI ESTIPULADO PELA FEBRABAN UMA DATA BASE PARA CALCULO DO FATOR DE //
    // VENCIMENTO, A DATA BASE É (07/10/1997) CONSTANTE. PARA CALCULO DO   //
    // FATOR DE VENCIMENTO, DEVE SE SUBTRAIR DA DATA DE VENCIMENTO, A DATA //
    // BASE E ENTAO SE OBTEM UM VALOR INTEIRO INDICANDO A QUANTOS DIAS DA  //
    // DATA BASE ESTAMOS  EX.                                              //
    //                                                                     //
    //                    23/12/2006 - 07/10/1997 = 3364                   //
    //                                                                     //
    //******************************************************************ED*//
    strFatVen := FloattoStr(dtaDtaVen - StrToDateTime('07/10/1997'));


    //*****************************************************//
    // VALIDA SE A QUANTIDADE DE DIAS DO VENCIMENTO EH     //
    // MENOR QUE 1000, SE SIM ENTAO FINALIZA               //
    //**************************************************ED*//
    If StrToInt(strFatVen) < 1000 Then
    Begin
      MessageDlg('A data de vencimento não deve ser inferior á : 03/07/2000', mtInformation, [mbok], 0);
      Application.Terminate;
    End;


    //******************************************************//
    // VERIFICA SE BANCO INFORMADA E SUPORTADO PELO SISTEMA //
    //                                                      //
    // SEMPRE QUE ACRESCENTAR UM BANCO, FAVOR CRIAR AS CONF.//
    // NO ARQUIVO EXEMPLOS.INI                              //
    //                                                      //
    //***************************************************ED*//
    fVerificaContido(strIdeBan, '_001_033_041_104_151_237_341_353_356_399_409_422_741_748_756_33B_021_', 'O número do banco');

    blnSantan := False;
    If strIdeBan = '033' Then
    Begin
      //***********************************************//
      // PROCESSA DADOS PARA O BANCO BANESPA - 033     //
      //********************************************ED*//
      pProArq033;
    End
    Else If strIdeBan = '353' Then
    Begin
      //***********************************************//
      // PROCESSA DADOS PARA O BANCO SANTANDER - 353   //
      //********************************************LU*//
      pProArq353;

    End
    Else If strIdeBan = '33B' Then
    Begin
      {***********************************************}
      {* PROCESSA DADOS PARA O BANCO SANTANDER - 033 *}
      {********************************************AF*}
      blnSantan := True;
      strIdeBan := '033';
      pProArq033B;

    End
    Else If strIdeBan = '021' Then
    Begin
      {***********************************************}
      {* PROCESSA DADOS PARA O BANCO BANESTES - 021  *}
      {********************************************AF*}
      strIdeBan := '021';
      pProArq021;

    End
    Else If strIdeBan = '341' Then
    Begin
      //***********************************************//
      // PROCESSA DADOS PARA O BANCO ITAU - 341        //
      //********************************************ED*//
      pProArq341;

    End
    Else If strIdeBan = '422' Then
    Begin
      //***********************************************//
      // PROCESSA DADOS PARA O BANCO SAFRA - 422       //
      //********************************************ED*//
      pProArq422;
    End
    Else If strIdeBan = '748' Then
    Begin
      //***********************************************//
      // PROCESSA DADOS PARA O BANCO SICREDI - 748     //
      //********************************************ED*//
      pProArq748;
    End
    Else If strIdeBan = '151' Then
    Begin
      //***********************************************//
      // PROCESSA DADOS PARA O BANCO NOSSA CAIXA - 151 //
      //********************************************ED*//
      pProArq151;
    End
    Else
    Begin
      fProArquivo(strIdeBan);
    End;


  End;

  CloseFile(arqTexto);

end;


procedure TfrmPrincipal.trvBancosDblClick(Sender: TObject);
begin

  memObserv.Clear;

  memObserv.Lines.Text := fRetornaLayout( LeftStr( trvBancos.Items.Item[trvBancos.Selected.AbsoluteIndex].Text, 3) );

end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
    Self.Caption := ' Impressão de Boleto Laser   -   Versão: ' + fRetornaVersao;
end;

end.

