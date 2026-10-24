{*******************************************}
{* UNIT DE FUNÇÕES E PROCEDURES DO SISTEMA *}
{****************************************DV*}
unit untFuncoes;

interface

uses
	Windows, Messages,
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, IniFiles,
  Buttons, DBCtrls, Uni, DB, Mask, Printers, EditFocus,
  DateUtils, MaskUtils,
  untTypesSistema,
  WinSock, cxProgressBar,
  IdMessageClient, IdPOP3, IdSocks, IdMessage, ShellApi, WinSpool,
  untFuncoesSimples, LbCipher, LbClass, LbUtils, UniClientDataSet, untConstantes;



Type
  TIndMenus = Record
    strNomForm: String;
End;



Type
  TLogAvi = record
    strDirAce,
    strNumLib,
    strInfBlo, //mensagem exibida ao usuário bloqueado
    strInfLib, //mensagem exibida ao usuário da liberação
    strMenObs,
    strCodOpe,
    strCodDig,
    strCodIte: String;
    intAutInc: Integer;
    blnIgnInc: Boolean;
    strMsgJso: String;
    strOpeLib: String;
  end;

Type
  TArrLogAvi = Array Of TLogAvi;

Type
  TTravaFaturamento = record
    strDirAce,
    strGrupo,
    strInformacao: String;
    blnCarregarLibPed: Boolean;
  end;

Type
  TArrTravaFaturamento = Array Of TTravaFaturamento;

  {*******************************}
  {*    PROCEDURES DO SISTEMA    *}
  {****************************DV*}


	procedure pRegistraUsuario(NomeUsuario,Evento:String);
  procedure pGravaLogDelecao(NomeTabela,NomeCampo,Informacao: String; dtaDataDelecao: TDateTime; intPosicao: Integer);
	procedure pAtuCaptionLabel(Objeto: TLabel; strString:String);
  procedure pRaise(const strMensagem: String);


  function fGravaCodSeq(strNomeTabela: String; intCodSeq: Integer): Boolean;
  function fRetCorEmpresa(strCodEmp: String): Integer;

  function fTemWhere(Const strSQL: String): Boolean;

  //function EnviaEMail(Handle: THandle; Mail: TStrings):Cardinal;

  procedure pFinalizaModulos;


  function fRetPosCadOpe(strCodOpe: String): String;
  function fRetCadOpePos(strRecNo: String): String;

  Function fCriptografaOperador(strCodOpe, strSenLib: String): String;
  Function fDescriptografaOperador(strSenLib: String): String;

  procedure pApagaTabelasTemporarias;

  procedure pZapTable(strNomeTabela: String);
  procedure pCriaApagaTrava(intCriApa: Integer);
  procedure pMostraMensTEF(frmNomeForm: TForm; strMensagem: String);


  procedure pResetaImpressora(Const strNomImp: String);

  {*******************************}
  {*     FUNCTION DO SISTEMA     *}
  {****************************DV*}
  Function fSetaVarAutoinc(strNomTab: String): Boolean;
  function fFormDesbloqueio: Boolean;
  function fConfirmaCadSenha(strSenha1,strSenha2: String): Boolean;

	function fIsEmpty(strNomeTabela: String):Boolean;

  function fRetornaProCod(strNomeTabela: String): String;

  function fRetornaSequencialUnico(strNomSeq: String): Integer;


  function fRetornaQtdRegistros(strTabela: String): Integer;

	function fNomeDoComputador: String;
	function fDiskInDrive(const Drive: char): Boolean;
  function fColocaAspas(strString:String): String;
	function fCompDatas(strDtaIni,strDtaFin:String): Boolean;

	function fAnyToStr (const Valor: variant): String;
  function fRetDiasNoMes(intAno, IntMes: Integer): Integer;
  function fTiraCaracter(strStr: String):String;
	function fGetUsuRede : String;
  function fFormataTamStr(strString: String; intLargura: Integer): String;
  function fValidaVencimento(var arrDuplicata: TarrDuplicata): Boolean;

  Function fRenomearArquivo( strArqOrigem, strArqDestino : String ):Boolean;
  function fTiraPontoVirgula(strValor: String): String;
  function fTransf(fltValor: Double; intInteiro, intDecimais: Integer): String;
  function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;
  function fGravaAutoIncrem(strNomeTabela: String; intAutInc: Integer): Boolean;

//  function fValidade_Sistema: Boolean;
  function fSeqLaser: String;
  function fPegaArquivoTxt: String;
  function fRetQtrStr(strSubStr, strString: String): Integer;
  function fCalcIcms: Boolean;
  function fPodeExcluirItem(strCodIte: String): Boolean;
  function fCriarProcesso(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean=True): boolean;
  function fVerificaIntegridadeOrigemDestino(strTabOri, strTabDes: String;
    Var lsvFantantes, lsvDivergentes: TListView): Boolean;

  function fRetPreCus(strCodEmp, strCodIte: String): Double;

  function fRetCodCidByCliente(strCodCli: String): String;
  function fDescriptografa(strTexto: AnsiString): AnsiString;
  function fCriptografa(strTexto: AnsiString): AnsiString;
  function fRetCodItem(strCodBar: String): String;
  function fRetNomeArquivoPAF(strNomeArq: String; strExt: String = '.txt'): String;
  function fRetHashArquivo(strNomeArq: String): String;
  function fRetHashString(strString: String): String;
  function fFloatToStrPonto(valor: double; inte,deci: integer): string;
  function fFloatToStrVirgula(valor: double; inte,deci: integer): string;

  {***********************************************}
  {* FUNÇÕES REFERENTES À ENTRADA DE MERCADORIAS *}
  {********************************************MV*}


  Function fVerificaValorVOutroXML(strAutEle: String): Boolean;



  Function fMemoToStr(strMemo: String): String;

  procedure pCarregaItens(strCodEmp: String; Var qryCadIte: TUniQuery);



  function fClienteFilialCadastrado(strCodCli, strCodEmp: String): Boolean;
  function fFornecedorFilialCadastrado(strCodFor, strCodEmp: String): Boolean;

  Function fRetornaSenCli( intNumero: Integer ): String;
  function fRetSenOperador(strCodOpe: String): String;
  function fRetornaStatusCadastro(strCodigo, strTipo, strTabela, strCampo: String): String;

  function fClienteFilial(strCodCli: String; Conexao: TUniConnection = Nil): Boolean; OverLoad;

  function fClienteFilial(strCodCli: String; Var strCodEmp: String; Conexao: TUniConnection = Nil): Boolean; OverLoad;

  function fGetPosLinha(strLinha, strDelimitador: String; intColuna: Integer): Integer;


  function fRetCgcCpf(strCodCli: String): String;
  function fVerBarraFinal(strPath: String): String;
//  function fAtuCodSeq(strChave, strCampo: String): String;

  function fRetDescri(strCampoRetorno, strCampoPesquisa , strNomeTabela , strCodigo: String): String;


  function fRetornaGrupoItem(strCodIte: String): String;

  function fRetCodForFilial: String; overload;
  function fRetCodForFilial(strCodEmp: String): String; overload;

  function fRetValorCampo(Const strSeqGer, strTabela, strAbrTbl, strCampo_: String): String;

  procedure pGeraBackup; // realiza o backup do sistema

  function fStringRepetida(Const strString: String): Boolean;



  {********************************}
  {* FUNCAO SIMILAR A POS()       *}
  {*****************************PH*}
  function fPos(const SubStr, S: String): Boolean;
  function fPosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;


  function fArquivoRetornoTxtBemaFI32: String;

//  procedure pLocksTravados(blnPerRem, blnMostraVazio: Boolean);

  procedure pDefineLayoutImpressao(strEspecie: String; Var strColRel, str40ColS: String;
    strEntFut: String);
  procedure pFinalizaLibrarys;

var
  fltJur: Double;

  blnImprime_Vencimentos_Orcamento : Boolean;

  arrLogAvi: TArrLogAvi;

  arrTravasLibFinalVenda: TArrTravaFaturamento;

  {*****************************************}
  {* TRUE CASO ESTEJA LIBERADO PARA CONFI- *}
  {* GURAR O BOLETO                        *}
  {**************************************MV*}
  blnLibCnf: Boolean;

  CorZebra : TColor;

  blnRede : Boolean;

  arrMenu       : Array Of TIndMenus;
  arrMenuPri    : Array Of TIndMenus;

  {*****************************************}
  {* VARIÁVEIS GLOBAIS DE CONFIGURAÇÃO MO- *}
  {* NETÁRIA                               *}
  {**************************************MV*}
  intPrecisao: Integer = 12;

  intMesGir: Integer;

  {*****************************************}
  {* REPRESENTA O COMANDO DE IMPRESSÃO     *}
  {**************************************MV*}
  strCmdLpr: String = 'lpr-cups';

implementation

uses  IdEMailAddress,
      untDesbloqueiodaCopia,
      untModulo,
      untPesqAux, {untRelacaoLocks, }untModuloReplicacao,
      untGravando;

{***********************************************************}
{*                                                         *}
{*    Procedure e Funções Utilizadas no Banco de Dados     *}
{*                                                         *}
{********************************************************DV*}

{***********************************}
{* VERIFICA SE TABELA ESTA VAZIA   *}
{********************************DV*}
function fIsEmpty(strNomeTabela: String):Boolean;
  Var
    qryGenTmp : TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS QTD FROM ' + strNomeTabela);
      Open;
      Result := FieldByName('QTD').AsInteger <= 0;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

{*********************************}
{* CONFIRMA SENHA DIGITADA       *}
{******************************DV*}
function fConfirmaCadSenha(strSenha1,strSenha2: String): Boolean;
begin
	Result := False;
  If strSenha1 = strSenha2 Then
  	Result := True;
end;

{*******************************************}
{* PEDE UMA DATA                           *}
{****************************************MV*}
{*********************************************************}
{* RETORNA O PROXIMO CODIGO, PORÉM NÃO ATUALIZA O PROCOD *}
{******************************************************MV*}
function fRetornaProCod(strNomeTabela: String): String;
  Var
    intCodigoAtual: Integer;
    intTamCodigo  : Integer;

    strSQL   : String;
    qryGenCod: TUniQuery;

begin
//  fLock_Unlock('PROCOD', True);

  Try
    pValidaProCod(strNomeTabela);

    qryGenCod := fCriaQuery;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PRO_CODSEQ AS CODSEQ, ';
      strSQL := strSQL + '  PRO_TAMCOD AS TAMCOD ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PROCOD ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
      strSQL := strSQL + ' FOR UPDATE ';

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        Open;

        If IsEmpty Then
        Begin
          Close;
          Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                 'na tabela de Próximos Codigos! Verifique.' + #13#10);
        End;

        intCodigoAtual := FieldByName('CODSEQ').AsInteger;
        intTamCodigo   := FieldByName('TAMCOD').AsInteger;
        Close;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

    Result := fPadL(IntToStr(intCodigoAtual), intTamCodigo, '0');

  Finally
    FreeAndNil(qryGenCod);
  End;

end;

function fRetornaQtdRegistros(strTabela: String): Integer;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabela;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := Fields[0].AsInteger;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function fRetornaSequencialUnico(strNomSeq: String): Integer;
  Var
    blnComita: Boolean;
    qryCfgSis: TUniQuery;

begin
  Try
    Result := 1;
    qryCfgSis := fCriaQuery(nil);

    blnComita := False;

    If Not frmModulo.GetCurrentConnection.InTransaction Then
    Begin
      fStartTransaction;
      blnComita := True;
    End;

    Try

      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT                     ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := VS_strCodEmp;
        ParamByName('CODCFG').Value := 'CFG_'+ strNomSeq;
        Open;

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := FieldByName('SIS_VALCFG').AsInteger
        Else
          Result := 1;

        fAtuCfgSis(strNomSeq, IntToStr(Result + 1));

      End;

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;

        Raise Exception.Create('Não consegui pegar o proximo sequencial de '+ strNomSeq +' em CFGSIS. Tente novamente!');
      End;
    End;

    If blnComita Then
      fCommit;

  Finally
    FreeAndNil(qryCfgSis);
  End;

End;



procedure pRegistraUsuario(NomeUsuario,Evento:String);
begin
{  Try
    fStartTransaction;
    With frmModulo.qryLogAce do
    Begin
	    Open;
      Insert;
      FieldByName('LOG_NOMUSU').AsString := NomeUsuario;
      FieldByName('LOG_DTALOG').AsDateTime := VS_Date;
      FieldByName('LOG_MAQUIN').AsString := fNomeDoComputador;
      If Evento = 'E' then
	      FieldByName('LOG_DESCRI').AsString := 'Entrou no Sistema'
      Else
  	    FieldByName('LOG_DESCRI').AsString := 'Saiu no Sistema';
      Post;
      fCommit;
      Close;
    End;
  Except
    On E : Exception do
    Begin
      pMensagensErro(E.Message, '[Registra Usuario]');
    End;
  End;}
End;

{***********************************}
{* RETORNA O NOME DO COMPURADOR    *}
{********************************MV*}
function fNomeDoComputador: String;
  {$IFDEF MSWINDOWS}
    Var
      dwrAux: DWord;
  {$ENDIF}
  {$IFDEF LINUX}
    Var
      hostName: PIOFile;
      pchrNomeMaq: Array[0..254] Of Char;
  {$ENDIF}
begin
  {$IFDEF LINUX}
    hostName := popen(PChar('hostname'), 'r');
    If fgets(pchrNomeMaq, 255, hostName) <> Nil Then
      Result := StrPas(pchrNomeMaq)
    Else
      Result := '';
  {$ENDIF}
  {$IFDEF MSWINDOWS}
    dwrAux := MAX_COMPUTERNAME_LENGTH + 1;
    SetLength(Result, dwrAux);
    Windows.GetComputerName(PChar(Result), dwrAux);
    Result := String(PChar(Result));
  {$ENDIF}
end;

{***********************************}
{* GRAVA LOG DE DELECAO            *}
{********************************DV*}
procedure pGravaLogDelecao(NomeTabela,NomeCampo,Informacao: String; dtaDataDelecao: TDateTime; intPosicao: Integer);
begin
{  Try
    fStartTransaction;
    With frmModulo.qryLogDel do
    Begin
	    Open;
      Insert;
      FieldByName('LOG_LOGOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_DTADEL').AsDateTime := dtaDataDelecao;
      FieldByName('LOG_TABELA').AsString   := NomeTabela;
      FieldByName('LOG_NOMCAM').AsString   := NomeCampo;
      FieldByName('LOG_INFOMA').AsString   := Informacao;
      FieldByName('LOG_POSCAM').AsInteger  := intPosicao;
      Post;
      fCommit;
      Close;
    End;
  Except
    On E : Exception do
    Begin
      pMensagensErro(E.Message, '[Log de Deleção]');
    End;
  End;}
end;

{****************************************}
{* VERIFICA SE EXISTE DISCO NA UNIDADE  *}
{*************************************DV*}
function fDiskInDrive(const Drive: char): Boolean;
{	Var
		DrvNum: byte;
		EMode: Word;}
begin
 {result := false;
 DrvNum := ord(Drive);
 if DrvNum >= ord('a') then dec(DrvNum,$20);
 EMode := SetErrorMode(SEM_FAILCRITICALERRORS);
 try
  if DiskSize(DrvNum-$40) <> -1 then
  	result := true
  else
  	messagebeep(0);
  finally SetErrorMode(EMode);
 end;}
 Result := True;
end;

{************************************}
{* COLOCA ASPAS SIMPLES NUMA STRING *}
{*********************************DV*}
function fColocaAspas(strString:String): String;
begin
	Result := #39 + strString + #39;
end;

{***********************************}
{* COMPARA DUAS DATAS             *}
{********************************DV*}
function fCompDatas(strDtaIni,strDtaFin:String): Boolean;
	Var
  	dtaDtaIni, dtaDtaFin : TDateTime;
begin
  Result := False;
  dtaDtaIni := StrToDateTime(strDtaIni);
  dtaDtaFin := StrToDateTime(strDtaFin);
	If dtaDtaIni > dtaDtaFin then
	Begin
    fMensagem('','A data final não pode ser menor que a data inicial.', ['&Ok']);
	End
	Else
	Begin
  	Result := True;
	End;
end;

{*************************************}
{* CONVERTE QUALQUER VALOR EM STRING *}
{**********************************DV*}
function fAnyToStr (const Valor: variant): String;
begin
  Case TVarData(Valor).vType Of
    varEmpty:     Result := 'Empty';
    varNull:      Result := 'Null';
    varSmallInt:  Result := IntToStr(Valor);
    varInteger:   Result := IntToStr(Valor);
    varSingle:    Result := FloatToStr(Valor);
    varDouble:    Result := FloatToStr(Valor);
    varCurrency:  Result := FloatToStr(Valor);
    varDate:      Result := DateToStr(Valor);
    varVariant:   Result := FloatToStr(Valor);
    varUnknown:   Result := '?';
    varByte:      Result := IntToStr(Valor);
    varString:    Result := Valor;
    varBoolean: Begin
                   If Valor Then
                      Result := 'TRUE'
                   Else
                      Result := 'FALSE';
                End;
  End;
end;

{*********************************}
{* ATUALIZA UM LABEL NUMA TELA   *}
{******************************DV*}
procedure pAtuCaptionLabel(Objeto: TLabel; strString:String);
begin
  Objeto.Caption := '';
  Objeto.Refresh;
  Objeto.Caption := strString;
  Objeto.Refresh;
end;

procedure pRaise(const strMensagem: String);
begin
  Raise Exception.Create(strMensagem);
end;

{*******************************************}
{* TIRA CARACTERES ESPECIAIS DE UMA STRING *}
{****************************************DV*}
function fTiraCaracter(strStr: String):String;
	Const
  	strCaracteres : String = ',.;';
  Var
  	intIndice: Integer;
begin
	Result := '';
	For intIndice := 1 To Length(strStr) Do
  Begin
  	If Pos(strStr[intIndice],strCaracteres) = 0 Then
    Begin
			Result := Result + strStr[intIndice];
    End;
  End;
end;

{************************************}
{* PEGA NOME DA ESTAÇÃO NA REDE     *}
{*********************************DV*}
function fGetUsuRede : String;
{	Var
		arrNetName: Array[0..48] of Char;
		iResult: DBIResult;}
Begin
{	iResult:= DBIGetNetUserName(arrNetName);
	If iResult <> DBIErr_None Then
  Begin
		DBIError( iResult )
  End
	Else
  Begin
		Result:= StrPas(arrNetName);
  End;}
end;

function fFormataTamStr(strString: String; intLargura: Integer): String;
begin
  Result := Copy(fstrEspaco(strString, intLargura), 1, intLargura);
end;

function fValidaVencimento(var arrDuplicata: TarrDuplicata): Boolean;
var
  intContador: integer;
begin
  Result      := True;
  intContador := 0;

  While (ArrDuplicata[intContador].dtaDtaVen <> '') And (intContador < 12) do
  begin
    if StrToDateTime(ArrDuplicata[intContador].dtaDtaVen) < VS_Date then
    begin
      Result := False;
      Break;
    end;

    Inc(intContador);
  end;
end;

{**********************************************************}
{* -> RENOMEIRA ARQUIVOS                                  *}
{*******************************************************WI*}
Function fRenomearArquivo( strArqOrigem, strArqDestino : String ):Boolean;
  Var
    intQtdSegundos  : Integer;
    timHoraAnterior : TDateTime;
Begin
  Result := False;

  timHoraAnterior := SysUtils.Time;
  While True Do
  Begin
    Application.ProcessMessages;
    If RenameFile( strArqOrigem, strArqDestino ) Then
    Begin
      Result := True;
      Break;
    End;
    intQtdSegundos := SecondOfTheDay( SysUtils.Time ) - SecondOfTheDay( timHoraAnterior );
    If ( intQtdSegundos > 5 ) Then
      Break;
  End;
End;

function fTiraPontoVirgula(strValor: String): String;
Begin
  Result := AnsiReplaceStr(strValor, '.', '');
  Result := AnsiReplaceStr(Result  , ',', '');
End;
{*****************************************}
{* EXECUTA UM TRANSF IGUAL O CLIPPER :^) *}
{**************************************MV*}
function fTransf(fltValor: Double; intInteiro, intDecimais: Integer): String;
  Var
    strMascara: String;
    strValorFormatado: String;
    intContador: Integer;
begin

  strMascara := '#.';

  For intContador := 1 To intDecimais Do
    strMascara := strMascara + '0';

  strValorFormatado := FormatFloat(strMascara, fltValor);
  Result            := fPadl(strValorFormatado, (intInteiro + intDecimais + 1), ' ') ;

end;


function fGravaAutoIncrem(strNomeTabela: String; intAutInc: Integer): Boolean;
  Var
    strSQL   : String;
    qryGenCod: TUniQuery;

begin
  Try

    qryGenCod := fCriaQuery;

    Try

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PROINC ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  PRO_AUTINC = :AUTINC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

      With qryGenCod Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsInteger := intAutInc;
        ParamByName('NOMARQ').AsString  := strNomeTabela;
        ExecSQL;
        Close;
        Result := True;

      End;

    Except

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaAutoIncrem]');
      End;
    End;

  Finally
    FreeAndNil(qryGenCod);
  End;

end;

{*****************************************}
{* RETORNA UM ARQUIVO TEMPORÁRIO LIVRE   *}
{**************************************MV*}
function fPegaArquivoTxt: String;
  Var
    strPath: String;
    intQtdPad: Integer;
    intContador: Integer;
    txtArquivo: TextFile;
begin
  strPath   := fCfgSis('PATTMP');
  intQtdPad := Length(IntToStr(MAX_ARQTMP));

  Result := '';

  For intContador := 0 To MAX_ARQTMP Do
  Begin

    If Not FileExists( fGetPath( strPath + 'tmp' + fPadL(IntToStr(intContador), intQtdPad, '0') + '.txt' ) ) Then
    Begin
      Result := fGetPath( strPath + 'tmp' + fPadL(IntToStr(intContador), intQtdPad, '0') + '.txt' );
      AssignFile(txtArquivo, Result);
      Rewrite(txtArquivo);
      CloseFile(txtArquivo);
      Break;
    End;

  End;

end;

{**********************************************}
{* RETORNA QUANTAS VEZES A STRING 'strSubStr' *}
{* APARECE NA STRING 'strString'              *}
{*******************************************MV*}
function fRetQtrStr(strSubStr, strString: String): Integer;
  Var
    intContador: Integer;
    intLenStr: Integer;
    intLenSubStr: Integer;
begin

  Result       := 0;
  intLenStr    := Length(strString);
  intLenSubStr := Length(strSubStr);

  For intContador := 1 To intLenStr - intLenSubStr + 1 Do
  Begin
    If Copy(strString, intContador, intLenSubStr) = strSubStr Then
      Inc(Result);
  End;

end;

procedure pAtualizaApgTmp;
  Var
    qryApgTmp: TUniQuery;
    dtaDtaTmp: TDateTime;
Begin
  Try
    {*****************************************}
    {* APAGA TABELAS TEMPORARIAS             *}
    {**************************************MV*}
    qryApgTmp := fCriaQuery(Nil);
    qryApgTmp.SQL.Add('SELECT * FROM APGTMP');
    qryApgTmp.Open;

    If qryApgTmp.IsEmpty Then
    Begin
      qryApgTmp.Append;
      qryApgTmp.FieldByName('APG_DTAAPG').AsDateTime := VS_Date;
      qryApgTmp.Post;
    End
    Else
    Begin
      dtaDtaTmp := qryApgTmp.FieldByName('APG_DTAAPG').AsDateTime;

      If dtaDtaTmp <> VS_Date Then
      Begin
        qryApgTmp.Edit;
        qryApgTmp.FieldByName('APG_DTAAPG').AsDateTime := VS_Date;
        qryApgTmp.Post;
      End;
    End;

    qryApgTmp.Close;
    FreeAndNil(qryApgTmp);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;



procedure pApagaTabelasTemporarias;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin

  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SHOW TABLES ';
    strSQL := strSQL + '  LIKE "TMP_%" ';

    With qryGenTmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While Not Eof Do
      Begin
        fDropTable(Fields[0].AsString);
        Next;
      End;

    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function fCalcIcms: Boolean;
begin
  Result := fCfgSis('CALICM', varBoolean);
end;

{*****************************************}
{* VERIFICA SE PODE EXCLUIR DETERMINADO  *}
{* ITEM                                  *}
{**************************************MV*}
function fPodeExcluirItem(strCodIte: String): Boolean;
  Var
    strSQL: String;
    qryGenIte : TUniQuery;

begin

  Try

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_SALDOS <> 0 ';
    strSQL := strSQL + '  AND ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      Result := False;
      If FieldByName('QTD').AsInteger = 0 Then
        Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;



{*****************************************}
{* VALIDA OS CAMPOS DA TABELA DESTINO,   *}
{* COM RELAÇÃO À TABELA ORIGEM, MAS NÃO  *}
{* FAZ O CONTRÁRIO                       *}
{**************************************MV*}
function fVerificaIntegridadeOrigemDestino(strTabOri, strTabDes: String;
  Var lsvFantantes, lsvDivergentes: TListView): Boolean;
  Var
    strSQLOri: String;
    strSQLDes: String;
    intContadorCampos: Integer;
    intContadorDiv: Integer;

    qryGenOri : TUniQuery;
    qryGenTmp : TUniQuery;

begin

  qryGenOri := fCriaQuery;
  qryGenTmp := fCriaQuery;

  Result := True;

  intContadorCampos := 0;
  intContadorDiv := 0;

  If Not fTabelaExiste(strTabDes) Then
  Begin
    lsvDivergentes.Items.Add;
    lsvDivergentes.Items[intContadorDiv].Caption := 'TODAS!';
    lsvDivergentes.Items[intContadorDiv].SubItems.Add(strTabDes);
    lsvDivergentes.Items[intContadorDiv].SubItems.Add('Tabela não Existe!!');
    Inc(intContadorDiv);

    Result := False;
  End;


  strSQLOri := 'DESCRIBE ' + strTabOri;
  strSQLDes := 'DESCRIBE ' + strTabDes;

  {*****************************************}
  {* ABRE ARQUIVO DE ORIGEM                *}
  {**************************************MV*}
  With qryGenTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQLOri);
    IndexFieldNames := 'Field';
    Open;
  End;

  {*****************************************}
  {* ABRE ARQUIVO DE DESTINO               *}
  {**************************************MV*}
  With qryGenOri Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQLDes);
    IndexFieldNames := 'Field';
    Open;
  End;

  {*****************************************}
  {* PROCESSA A TABELA ORIGEM              *}
  {**************************************MV*}
  While (Not qryGenTmp.Eof) Do
  Begin

    If (qryGenOri.Eof) Then
    Begin
      lsvFantantes.Items.Add;
      lsvFantantes.Items[intContadorCampos].Caption := qryGenTmp.FieldByName('Field').AsString;
      lsvFantantes.Items[intContadorCampos].SubItems.Add(strTabDes);
      Inc(intContadorCampos);
      Result := False;
    End

    Else If (qryGenTmp.FieldByName('Field').AsString <>
             qryGenOri.FieldByName('Field').AsString) Then
    Begin

      If (qryGenTmp.FieldByName('Field').AsString <
          qryGenOri.FieldByName('Field').AsString) Then
      Begin

        lsvFantantes.Items.Add;
        lsvFantantes.Items[intContadorCampos].Caption := qryGenTmp.FieldByName('Field').AsString;
        lsvFantantes.Items[intContadorCampos].SubItems.Add(strTabDes);
        Inc(intContadorCampos);

        // Next no Arquivo Original
        qryGenTmp.Next;
        Result := False;
        Continue;

      End
      Else
      Begin

        // Next no Arquivo Destino
        qryGenOri.Next;
        Continue;

      End;

    End
    Else If (qryGenTmp.FieldByName('Type').AsString <>
             qryGenOri.FieldByName('Type').AsString) Then
    Begin

      lsvDivergentes.Items.Add;
      lsvDivergentes.Items[intContadorDiv].Caption := qryGenTmp.FieldByName('Field').AsString;
      lsvDivergentes.Items[intContadorDiv].SubItems.Add(strTabDes);
      lsvDivergentes.Items[intContadorDiv].SubItems.Add(qryGenTmp.FieldByName('Field').AsString + ': ' +
        strTabOri + ' tem tipo ' + qryGenTmp.FieldByName('Type').AsString +
        ' e ' + strTabDes + ' tem tipo ' + qryGenOri.FieldByName('Type').AsString);

      Inc(intContadorDiv);
      Result := False;

    End
    Else If (qryGenTmp.FieldByName('Null').AsString <>
             qryGenOri.FieldByName('Null').AsString) Then
    Begin

      If fEmptyStr(qryGenTmp.FieldByName('Null').AsString) Then
      Begin
        //Campo caixa2 permite nulo e caixa 1 nao
        lsvDivergentes.Items.Add;
        lsvDivergentes.Items[intContadorDiv].Caption := qryGenTmp.FieldByName('Field').AsString;
        lsvDivergentes.Items[intContadorDiv].SubItems.Add(strTabOri);
        lsvDivergentes.Items[intContadorDiv].SubItems.Add(qryGenTmp.FieldByName('Field').AsString + ': ' +
          strTabDes + ' permite nulo e ' + strTabOri + ' não permite ');

        Inc(intContadorDiv);
        Result := False;
      End
      Else
      Begin
        //Campo caixa1 permite nulo e caixa 2 nao
        lsvDivergentes.Items.Add;
        lsvDivergentes.Items[intContadorDiv].Caption := qryGenTmp.FieldByName('Field').AsString;
        lsvDivergentes.Items[intContadorDiv].SubItems.Add(strTabOri);
        lsvDivergentes.Items[intContadorDiv].SubItems.Add(qryGenTmp.FieldByName('Field').AsString + ': ' +
          strTabOri + ' permite nulo e ' + strTabDes + ' não permite ');

        Inc(intContadorDiv);
        Result := False;
      End

    End;

    qryGenTmp.Next;
    qryGenOri.Next;

  End;

  FreeAndNil(qryGenOri);
  FreeAndNil(qryGenTmp);

end;


function fRetCodCidByCliente(strCodCli: String): String;
Begin
  Result := fCampoTabela('CLI_CODCID', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
End;

function fRetPreCus(strCodEmp, strCodIte: String): Double;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_PRECUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := 0;

    If (Not IsEmpty) And (Not FieldByName('ITE_PRECUS').IsNull) Then
      Result := FieldByName('ITE_PRECUS').AsFloat;

    Close;
  End;

  FreeAndNil(qryTmp);

End;


{*****************************************}
{* GERA UMA TABELA TEMPORARIA COM TODOS  *}
{* OS ITENS DA NOTA FISCAL ELETRONICA    *}
{**************************************LA*}

Function fVerificaValorVOutroXML(strAutEle: String): Boolean;
   Var
     qryVOutro: TUniQuery;
Begin
  qryVOutro := fCriaQuery;
  With qryVOutro, SQL Do
  Begin
    Add('SELECT SUM(IFNULL(I17A_VOUTRO, 0) + IFNULL(I16_VSEG, 0)) AS DESACE');
    Add('FROM');
    Add('  DETELE');
    Add('WHERE ');
    Add('  DET_SEQGER = :SEQGER ');

    ParamByName('SEQGER').AsString := strAutEle;

    Open;

    Result := FieldByName('DESACE').AsFloat > 0;

    Close;
 End;

 FreeAndNil(qryVOutro);
End;


function fRetornaValorOutras(fltVlrCon, fltBasIcm, fltValIpi, fltValRet, fltVleRet, fltVleIpi, fltVFCPST: Double): Double;
begin

  Result := fFormataFloat(fltVlrCon - (fltBasIcm + fltValIpi + fltValRet + fltVleRet + fltVleIpi + fltVFCPST), 2);
  If Result <= 0.0 Then
    Result := 0.0;

end;

function fRetornaAlqFor(strEstFor, strIesFor: String; strEstEmp: String = ''): Double;
begin
  If strEstEmp = '' Then
    strEstEmp := fCadEmp('ESTADO');

  If (strEstFor = strEstEmp) Then
  Begin
    Result := 18;
    If (strEstFor = 'RS') Then
      Result := 17;
  End
  Else If (Pos(strEstFor, 'PR_RJ_MG_RS_SC_SP_ES_') > 0) Then
  Begin
    Result := 12;
  End
  Else
  Begin
    Result := 07;
  End;

  If (fEmptyStr(strIesFor)) And (strEstFor <> strEstEmp) Then
    Result := 18;

end;

{*****************************************}
{* CARREGA TODOS OS ITENS DE UMA DETER-  *}
{* MINADA EMPRESA                        *}
{**************************************MV*}
procedure pCarregaItens(strCodEmp: String; Var qryCadIte: TUniQuery);
  Var
    strSQL: String;
    strCodigos: String;
    intRecordCount: Integer;

begin

  strSQL := strSQL + '    SELECT ';
  strSQL := strSQL + '      DISTINCT ENT_CODITE ';
  strSQL := strSQL + '    FROM ';
  strSQL := strSQL + '      TMP_ENTMER ';

  With qryCadIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    intRecordCount := RecordCount;

    While Not Eof Do
    Begin

      strCodigos := strCodigos + QuotedStr(FieldByName('ENT_CODITE').AsString);
      If RecNo <> intRecordCount Then
        strCodigos := strCodigos + ', ';

      Next;

    End;

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_INCPIS, ';
  strSQL := strSQL + '  I.ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_CODMAR, ';
  strSQL := strSQL + '  I.ITE_EMBALA, ';  
  strSQL := strSQL + '  G.ITE_FORULT, ';
  strSQL := strSQL + '  G.ITE_NOTULT, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06, ';
  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_VALFRE, ';
  strSQL := strSQL + '  G.ITE_ACRFIN, ';
  strSQL := strSQL + '  G.ITE_SUBSTI, ';
  strSQL := strSQL + '  G.ITE_DESADB, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_MARBR1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_MARBR2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_MARBR3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_MARBR4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_MARBR5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_MARBR6, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';
  strSQL := strSQL + '  G.ITE_MARBR7, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';
  strSQL := strSQL + '  GC.GRU_OPERES AS ITE_OPERES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR ';
  strSQL := strSQL + '  LEFT JOIN GRU_COMPRA GC ON I.ITE_GRUCMP = GC.GRU_CODIGO ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  I.ITE_CODITE IN ( ' + strCodigos + ' ) ';

  With qryCadIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

  End;

end;

function fClienteFilialCadastrado(strCodCli, strCodEmp: String): Boolean;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try
    Result := False;

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CLIFIL = :CODCLI AND ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;

      Close;
    End;
  Finally
    FreeAndNil(qryGenEmp);
  End;
end;

function fFornecedorFilialCadastrado(strCodFor, strCodEmp: String): Boolean;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try
    Result := False;

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_FORFIL =  :CODFOR AND ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;

      Close;
    End;
  Finally
    FreeAndNil(qryGenEmp);
  End;
end;

{********************************************}
{* RETORNA A SENHA PARA LIBERACAO DE BLO-   *}
{* QUEIO DE CLIENTES                        *}
{*****************************************WI*}
Function fRetornaSenCli( intNumero: Integer ): String;
  Var
    intNumSenha : Int64;
Begin

  intNumSenha := StrToIntDef(RightStr(IntToStr(YearOf(VS_Date)),02), 0);
  intNumSenha := intNumSenha * DayOf(VS_Date);
  intNumSenha := intNumSenha * intNumero;
  intNumSenha := intNumSenha * 99999999;
  intNumSenha := intNumSenha * MonthOf(VS_Date);

  Result := Trim(IntToStr(intNumSenha));
  Result := RightStr( Result, 07 );

End;

{*****************************************}
{* RETORNA A SENHA DO OPERADOR JA DESCRI-*}
{* PTOGRAFADO                            *}
{**************************************MV*}


function fRetornaStatusCadastro(strCodigo, strTipo, strTabela, strCampo: String): String;
  Var
    strSql: String;
    qryCad: TUniQuery;
begin

  strSql := '';
  strSql := strSql + ' SELECT                   ';
  strSql := strSql + '   ' + strTipo + '_STATUS ';
  strSql := strSql + ' FROM                     ';
  strSql := strSql + strTabela;
  strSql := strSql + ' WHERE                    ';
  strSql := strSql + strCampo + ' = :CODIGO     ';

  qryCad := fCriaQuery(Nil);

  With qryCad Do
  Begin
    SQL.Add(strSql);
    ParamByName('CODIGO').AsString := strCodigo;
    Open;
    Result := Fields[0].AsString;
    Close;
  End;

  FreeAndNil(qryCad);

end;



function fRetSenOperador(strCodOpe: String): String;
  Var
    strSQL   : String;
    qryGenOpe: TUniQuery;

begin
  Try

    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  OPE_SENOPE AS SENOPE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODOPE = :CODOPE ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;
      Result := fDecrypt(FieldByName('SENOPE').AsString);
      Close;

    End;

  Finally
    FreeAndNil(qryGenOpe);
  End;

end;

{*****************************************}
{* RETORNA SE É CLIENTE FILIAL           *}
{**************************************MV*}
function fClienteFilial(strCodCli: String; Conexao: TUniConnection = Nil): Boolean;
begin
  Result := (Not fEmptyStr(strCodCli)) And
            (fCampoTabela('COUNT(*)', 'CADEMP', ['EMP_CLIFIL'], [strCodCli], False, '', Conexao) > 0);
end;

function fClienteFilial(strCodCli: String; Var strCodEmp: String; Conexao: TUniConnection = Nil): Boolean;
begin
  strCodEmp := fCampoTabela('EMP_CODEMP', 'CADEMP', ['EMP_CLIFIL'], [strCodCli], False, '', Conexao);

  Result := (Not fEmptyStr(strCodCli)) And (Not fEmptyStr(strCodEmp));
end;

procedure pZapTable(strNomeTabela: String);
  Var
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM ' + strNomeTabela);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure pFinalizaModulos;
begin

//

end;

{**********************************************}
{* RETORNA A POSIÇÃO DA 'intColuna' LINHA DE  *}
{* UMA STRING SEPARADA POR 'strDelimitador'   *}
{*******************************************MV*}
function fGetPosLinha(strLinha, strDelimitador: String; intColuna: Integer): Integer;
  Var
    intContador: Integer;
    intContDel: Integer;
    intQtdCol: Integer;
begin

  intQtdCol := 0;

  intContador := 1;
  intContDel  := 1;

  While (intContDel < intColuna) Do
  Begin

    If (strLinha[intContador] = strDelimitador) Then
    Begin
      Inc(intQtdCol);
    End;
    Inc(intContador);

    If (intQtdCol = intColuna) Then
    Begin
      Break;
    End;

  End;

  Result := intContador;

end;

function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;
  Var
    iniArqIni: TIniFile;
Begin
  iniArqIni := TIniFile.Create(strPath + '\opcoes.ini');
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;

End;



{***************************************}
{* RETORNA O CPF OU CGC DE DETERMINADO *}
{* CLIENTE                             *}
{************************************AF*}
function fRetCgcCpf(strCodCli: String): String;
  Var
    strSQL   : String;
    qryGenCli: TUniQuery;

Begin
  Try

    qryGenCli := fCriaQuery;

    Result := '';
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CLI_C_G_C_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      Result := FieldByName('CLI_C_G_C_').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

End;

{********************************************}
{* VERIFICA SE O PATH PASSADO POR PARAMETRO *}
{* ESTA NA FORMA CORRETA, CASO CONTRARIO    *}
{* CORRIGE                                  *}
{*****************************************AF*}
function fVerBarraFinal(strPath: String): String;
Begin
  Result := Trim(strPath);

  If RightStr(Trim(strPath),1) <> '\' Then
  Begin
    Result := Trim(strPath) + '\';
  End;

End;

{********************************}
{* RETORNA O CODIGO SEQUENCIAL  *}
{* DAS CONFIGURACOES E ATUALIZA *}
{* --> AUTBAN <---              *}
{*****************************AF*}
{function fAtuCodSeq(strChave, strCampo: String): String;
  Var
    strProxNum: String;
    intNumero : Integer;
Begin
  strProxNum := Trim(fArqIniAutban(0, strChave, strCampo, ''));

  If Not fEmptyStr(strProxNum) Then
  Begin

    intNumero := StrToIntDef(strProxNum, 0);
    Inc(intNumero);
    strProxNum := IntToStr(intNumero);
    Result     := strProxNum;
    fArqIniAutban(1, strChave, strCampo, strProxNum);

  End
  Else
  Begin

    strProxNum := '1';
    Result     := strProxNum;
    fArqIniAutban(1, strChave, strCampo, strProxNum);

  End;

End;}

function fRetornaGrupoItem(strCodIte: String): String;
begin
  Result := fCampoTabela('ITE_CODGRU', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
end;

{***************************************}
{* RETORNA O NOME DO BANCO PASSADO POR *}
{* PARAMETRO                           *}
{************************************AF*}
{***********************************}
{* VERIFICA SE DUPLICATA EXISTE    *}
{********************************LB*}


{**********************************}
{* RETORNA O RESULTADO DE UMA SQL *}
{*******************************ED*}
function fRetDescri(strCampoRetorno, strCampoPesquisa , strNomeTabela , strCodigo: String): String;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + strCampoRetorno + ' AS RESULTADO ' ;
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strNomeTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + strCampoPesquisa + ' = :CODIGO ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODIGO').AsString := strCodigo;
      Open;
      Result := FieldByName('RESULTADO').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

//****************************************************//
// PROCEDURE QUE CRIA OU APAGA O ARQUIVO GERADO PARA  //
// A TRAVA DO SISTEMA                                 //
// 0 - CRIA O ARQUIVO                                 //
// 1 - APAGA O ARQUIVO DA TRAVA                       //
//*************************************************ED*//
procedure pCriaApagaTrava(intCriApa: Integer);
  Var
    strPatTra: String;
    txfArqTex: TextFile;
Begin

  strPatTra := Trim(ExtractFilePath(Application.ExeName) + 'MySqlSys.dll');

  //*****************************************************//
  // VERIFICA SE DEVE CRIAR OU APAGAR A TRVA             //
  // 0 = INDICA QUE DEVE CRIAR O ARQUIVO                 //
  //**************************************************ED*//
  If intCriApa = 0 Then
  Begin
    AssignFile(txfArqTex, strPatTra);
    Rewrite(txfArqTex);
    Writeln(txfArqTex, '');
    CloseFile(txfArqTex);
  End
  //*****************************************************//
  // VERIFICA SE DEVE CRIAR OU APAGAR A TRVA             //
  // 1 = INDICA QUE DEVE DELETAR O ARQUIVO               //
  //**************************************************ED*//
  Else
  Begin
    DeleteFile(strPatTra);
  End;

End;

function fFormDesbloqueio: Boolean;
  Var
    frmDesbloqueiodaCopia : TfrmDesbloqueiodaCopia;
Begin

  Try
    pCriarFormularios(TfrmDesbloqueiodaCopia, frmDesbloqueiodaCopia);
    frmDesbloqueiodaCopia.ShowModal;
    Result := frmDesbloqueiodaCopia.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fFormDesbloqueio]');
    End;
  End;
  pFreeAndNil(frmDesbloqueiodaCopia);

End;

{********************************}
{* CARREGA O FORNECEDOR FILIAL  *}
{* DO CADASTRO DE EMPRESAS      *}
{*****************************LB*}
function fRetCodForFilial: String;
Begin
  Result := fRetCodForFilial(VS_strCodEmp);
End;

function fRetCodForFilial(strCodEmp: String): String; overload;
  Var
    strSQL    : String;
    qryGenFil : TUniQuery;
Begin
  Try

    qryGenFil := fCriaQuery;

    Result := '';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_FORFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenFil Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('EMP_FORFIL').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenFil);
  End;

End;


function fSeqLaser: String;
  Var
    strSequen: String;
Begin

  fStartTransaction;

  Try

    If fEmptyStr( fCfgSisL('SEQLAS') ) Then
      strSequen := '000001'
    Else
      strSequen := fStrZero(VarToStr(fCfgSisL('SEQLAS')), 6);

    Result := strSequen;

    fAtuCfgSis('SEQLAS', fStrZero(IntToStr(StrToIntDef(strSequen, 0) + 1),6));
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise;
    End;
  End;

end;





Function fMemoToStr(strMemo: String): String;
Var
  stlInf: TStringList;
  intInd: Integer;
Begin
  Result := '';
  stlInf := TStringList.Create;
  stlInf.Text := strMemo;
  For intInd := 0 to stlInf.Count -1 Do
    Result := Result + Trim(stlInf[intInd]) + ' ';
  Result := Trim(Result);
  FreeAndNil(stlInf);
End;

{**************************************}
{* CHAMA UM OUTRO EXECUTÁVEL EM UM    *}
{* PROCESSO SEPARADO                  *}
{***********************************AF*}
function fCriarProcesso(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean=True): boolean;
begin
  Result := fCriarProcessoSimples(strArquivo, blnTrava, blnMaximizado);
end;


{*****************************************}
{* ESSA BAGAÇA VAI RETORNA A POSICAO     *}
{* RECNO DO OPERDOR NO CADASTRO ORDENADO *}
{* POR CODIGO                            *}
{**************************************AF*}
function fRetPosCadOpe(strCodOpe: String): String;
  Var
    qryGen: TUniQuery;
Begin

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT       ');
    SQL.Add('  OPE_CODOPE ');
    SQL.Add('FROM         ');
    SQL.Add('  CADOPE     ');
    SQL.Add('ORDER BY     ');
    SQL.Add('  OPE_CODOPE ');
    Open;

    While Not Eof Do
    Begin

      If FieldByName('OPE_CODOPE').AsString = strCodOpe Then
      Begin
        Result := fStrZero(RecNo,3);
        Break;
      End;

      Next;
    End;

    Close;
  End;

  FreeAndNil(qryGen);

End;

{*****************************************}
{* RETORNA CODOPE PELO RECNO             *}
{**************************************AF*}
function fRetCadOpePos(strRecNo: String): String;
  Var
    qryGen: TUniQuery;
Begin

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT       ');
    SQL.Add('  OPE_CODOPE ');
    SQL.Add('FROM         ');
    SQL.Add('  CADOPE     ');
    SQL.Add('ORDER BY     ');
    SQL.Add('  OPE_CODOPE ');
    Open;

    RecNo := StrToIntDef(strRecNo,0);
    Result := FieldByName('OPE_CODOPE').AsString;

    Close;
  End;

  FreeAndNil(qryGen);

End;

Function fCriptografaOperador(strCodOpe, strSenLib: String): String;
  Var
    intFat,
    intOpe: int64;
    intInd: Integer;
    intSom: Integer;
Begin
  intFat := StrToInt64Def(RightStr(LeftStr(strSenLib,5),3),0);
  intOpe := StrToInt64Def(fRetPosCadOpe(strCodOpe),0);
  Result := IntToStr(intFat*IntOpe);

  (**************************************************)
  (* ACRESCENTA DIGITO VERIFICADOR                  *)
  (***********************************************LA*)
  intSom := 0;
  For intInd := 1 to Length(Result) Do
    inc(intSom,StrToIntDef(Result[intInd],0));

  intSom := intSom mod 11;

  Result := Result + LeftStr(IntToStr(intSom),1);

End;

Function fDescriptografaOperador(strSenLib: String): String;
  Var
    intFat,
    intSen,
    intOpe: int64;
    chrDig: Char;
    intSom,
    intInd: Integer;
Begin
  intOpe := 0;
  intFat := StrToInt64Def(RightStr(LeftStr(strSenLib,5),3),1);

  If intFat = 0 then
  Begin
    Result := '';
    Exit;
  end;  

  delete(strSenLib,1,7);

  chrDig := strSenLib[Length(strSenLib)];

  delete(strSenLib,Length(strSenLib),1);

  intSom := 0;
  For intInd := 1 to Length(strSenLib) Do
    inc(intSom,StrToIntDef(strSenLib[intInd],0));

  intSom := intSom mod 11;

  If LeftStr(IntToStr(intSom),1) <> chrDig Then
  Begin
    Result := '';
    Exit;
  End;

  intSen := StrToInt64Def(strSenLib,0);

  If intFat <> 0 Then
    intOpe := intSen div intFat;

  Result := fRetCadOpePos(IntToStr(intOpe));
End;


function fRetValorCampo(Const strSeqGer, strTabela, strAbrTbl, strCampo_: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT ' + strCampo_ + ' FROM ' + strTabela + ' WHERE ' + strAbrTbl + '_SEQGER = :SEQGER LIMIT 1');
  qryAux.ParamByName('SEQGER').AsString := strSeqGer;
  qryAux.Open;
  Result := qryAux.FieldByName(strCampo_).AsString;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

(**********************************************************************)
(* SETA UMA VARIAVEL NO BANCO DE DADOS COM O PROXIMO AUTOINCREMENTO   *)
(* DA TABELA PASSADA COMO PARAMETRO                                   *)
(*******************************************************************LA*)
Function fSetaVarAutoinc(strNomTab: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try

    qryGen := fCriaQuery;

    Try

      With qryGen, Sql Do
      Begin
        Close;
        Clear;
        Add('SET @INC' + strNomTab + '=(SELECT IFNULL(CAST( LEFT(MAX(AUTOINCREM),17) AS UNSIGNED),0) AS AUTO FROM ' + strNomTab + ')');
        ExecSQL;
        Close;

        Result := TRUE;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
				pMensagensErro(E.Message,'[fSetaVarAutoinc]');
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

{****************************************}
{* MOSTRA MENSAGEM DO TEF (OBRIGATÓRIA) *}
{*************************************AF*}
procedure pMostraMensTEF(frmNomeForm: TForm; strMensagem: String);
  Var
    intContador: Integer;
Begin

  For intContador := 0 To frmNomeForm.ComponentCount - 1 Do
  Begin

    If frmNomeForm.Components[intContador].Name = 'pnlMenTef' Then
    Begin
      Application.ProcessMessages;
      (frmNomeForm.Components[intContador] As TPanel).Caption := strMensagem;
      (frmNomeForm.Components[intContador] As TPanel).Refresh;
      Application.ProcessMessages;
      Break;
    End;

  End;

End;

{****************************************}
{* REALIZA O BACKUP DO BANCO DE DADOS   *}
{*************************************LU*}
procedure pGeraBackup;
Var
  strHost   : String;
  strBanc   : String;
  strUsua   : String;
  strSenh   : String;
  txtText   : TextFile;
  strArqBat : String;
  strArqBac : String;
  strComand : String;
  strWinRar : String;
  strExtArq : String;
Begin

  If fMensagem('AVISO', 'Confirma geração do Backup?', ['&Sim', '&Não']) = 1 Then
  Begin
    {************************************************************}
    {* VERIFICA SE O PATH PARA GERAR O ARQUIVO ESTÁ CONFIGURADO *}
    {*********************************************************LU*}
    If fEmptyStr(fCfgSis('PATBAC')) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Path para geração do arquivo deve ser configurado!', ['&Ok']);
      exit;
    End;

    Try
      Try
        strArqBat := 'BACKUP.BAT';
        strArqBac := '\BACKUP_' + FormatDateTime('yyyymmdd',VS_Date) + FormatDateTime('hhnnss',fTime());

        strHost := frmModulo.GetCurrentConnection.Server;
        strBanc := frmModulo.GetCurrentConnection.Database;
        strUsua := frmModulo.GetCurrentConnection.Username;
        strSenh := frmModulo.GetCurrentConnection.Password;

        {***********************}
        {* CRIA O ARQUIVO .BAT *}
        {********************LU*}
        AssignFile(txtText, fCfgSis('PATBAC') + '\' +  strArqBat);
        Rewrite(txtText);

        strComand := 'mysqldump -u' + strUsua +
                     ' -p' + strSenh +
                     ' -h' + strHost +
                     ' ' + strBanc +
                     ' > ' + fCfgSis('PATBAC') +
                     strArqBac + '.SQL';

        Writeln(txtText,strComand);
        Writeln(txtText,'Pause');

      Finally
        Flush(txtText);
        CloseFile(txtText);
      End;

      If FileExists(fCfgSis('PATBAC') + '\' + strArqBat) Then
      Begin
        {**************************}
        {* EXECUTA O ARQUIVO .BAT *}
        {***********************LU*}
        fCriarProcesso(fCfgSis('PATBAC') + '\' + strArqBat, True);
        strExtArq := '.SQL';
        {************************}
        {* APAGA O ARQUIVO .BAT *}
        {*********************LU*}
        DeleteFile(fCfgSis('PATBAC') + '\' + strArqBat);

        {**********************************************}
        {* VERIFICA SE ESTÁ CONFIGURADO O COMPACTADOR *}
        {*******************************************LU*}
        If Not fEmptyStr(fCfgSis('PATWRA')) Then
        Begin
          strWinRAR := '';
          strWinRAR := fCfgSis('PATWRA');
          strWinRAR := strWinRAR + ' a -afZip -m5 -ep ' + fCfgSis('PATBAC') + '\' + strArqBac + '.ZIP ';
          strWinRAR := strWinRAR + fCfgSis('PATBAC') + '\' + strArqBac +'.SQL ';

          WinExec(PAnsiChar(AnsiString(strWinRAR)),SW_SHOWNORMAL);

          {****************************************************}
          {* QD FINALIZA A COMPACTAÇÃO, EXCLUI O ARQUIVO .SQL *}
          {*************************************************LU*}
          While FileExists(fCfgSis('PATBAC') + '\' + strArqBac + strExtArq) Do
          Begin
            DeleteFile(fCfgSis('PATBAC') + '\' + strArqBac + strExtArq);
          End;

          strExtArq := '.ZIP';
        End;

        fMensagem('ATENÇÃO!', 'Backup realizado com sucesso!' + #13#10 + fCfgSis('PATBAC') + strArqBac + strExtArq, ['&Ok']);

      End;

    Except
      On E : Exception Do
        pMensagensErro(E.Message, 'Erro na realização do Backup');
    End;

  End;

End;

{********************************************}
{* CRIADO PARA UTILIZACAO DE OUTRAS         *}
{* VARIAVEIS SEM FICAR PRESO A arrDuplicata *}
{*****************************************AF*}


function fStringRepetida(Const strString: String): Boolean;
  Var
    intContador: Integer;
    strPrimeiro: String;
begin

  Result := True;
  If Length(strString) <= 0 THen
    Exit;

  strPrimeiro := strString[1];
  For intContador := 2 To Length(strString) Do
  Begin
    If strString[intContador] <> strPrimeiro Then
    Begin
      Result := False;
      Break;
    End;
  End;

end;

procedure pResetaImpressora(Const strNomImp: String);
  Var
    DocInfo: TDocInfo1;
    PrinterHandler: NativeUInt;
    escritos: Cardinal;
    strTexto: AnsiString;
begin
  OpenPrinter(PChar(strNomImp), PrinterHandler, Nil);
  with DocInfo do
  begin
    pDatatype := 'RAW';
    pDocName := PChar('Impressão de Faturamento');
    pOutputFile := nil;
  end;
  StartDocPrinter(PrinterHandler, 1, @DocInfo);
  StartPagePrinter(PrinterHandler);
  strTexto := AnsiString(#27 + '@');
  WritePrinter(PrinterHandler, PAnsiChar(strTexto), 2, escritos);

  ClosePrinter(PrinterHandler);
end;


{*****************************************}
{* VERIFICA SE UMA SENTENÇA SQL JÁ TEM A *}
{* CLÁUSULA 'WHERE'                      *}
{**************************************MV*}
function fTemWhere(Const strSQL: String): Boolean;
begin
  Result := Pos('where', AnsiLowerCase(strSQL)) > 0;
end;


{*******************************************}
{* RETORNA QTS DIAS TEM UM DETERMINADO MÊS *}
{****************************************LU*}
function fRetDiasNoMes(intAno, IntMes: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
Begin

  Result := DaysInMonth[IntMes];

  if IntMes = 2 then
  begin

    If (IntAno Mod 4) = 0 Then
      Result := 29;

  End;

End;

function fPos(const SubStr, S: String): Boolean;
begin
  Result := Pos(SubStr, S) > 0;
end;                            

function fPosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;


function fRetCorEmpresa(strCodEmp: String): Integer;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_CORFUN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := StrToIntDef(FieldByName('EMP_CORFUN').AsString,0);

      If Result = 0 Then
        Result := clWhite;

      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

End;

function fGravaCodSeq(strNomeTabela: String; intCodSeq: Integer): Boolean;
  Var
    strSQL   : String;
    qryGenCod: TUniQuery;
begin
  Try

    qryGenCod := fCriaQuery;

    Try

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PROCOD ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  PRO_CODSEQ = :CODSEQ ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

      With qryGenCod Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODSEQ').AsInteger := intCodSeq;
        ParamByName('NOMARQ').AsString  := strNomeTabela;
        ExecSQL;
        Close;
        Result := True;

      End;

    Except

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaProCod]');
      End;
    End;

  Finally
    FreeAndNil(qryGenCod);
  End;

end;



function fDescriptografa(strTexto: AnsiString): AnsiString;
  Var
    blowfish: TLbBlowfish;
begin
  blowfish := TLbBlowfish.Create(Nil);
  blowfish.GenerateKey(CHAVE_PRIVADA);
  Result := blowfish.DecryptString(Ansistring(strTexto));
  FreeAndNil(blowfish);
end;

function fCriptografa(strTexto: AnsiString): AnsiString;
  Var
    blowfish: TLbBlowfish;
begin
  blowfish := TLbBlowfish.Create(Nil);
  blowfish.GenerateKey(CHAVE_PRIVADA);
  Result := blowfish.EncryptString(Ansistring(strTexto));
  FreeAndNil(blowfish);
end;


function fRetCodItem(strCodBar: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  ITE_CODITE ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADITE ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  ITE_CODBAR = :CODBAR ');

  qryAux.ParamByName('CODBAR').AsString := strCodBar;
  qryAux.Open;

  Result := qryAux.FieldByName('ITE_CODITE').AsString;

  FreeAndNil(qryAux);
end;

function fRetNomeArquivoPAF(strNomeArq: String; strExt: String = '.txt'): String;
  Var
    strDirSai: String;
begin
  strDirSai := ExtractFileDir(Application.ExeName) + '\PAF\';

  If (Not DirectoryExists(strDirSai)) Then
    CreateDir(strDirSai);

  Result    := strDirSai + strNomeArq + '_' + FormatDateTime('yyyy-mm-dd_hhnnss', fNow()) + strExt;
end;

function fRetHashArquivo(strNomeArq: String): String;
  Var
    md5: TLbMD5;
    digest: TMD5Digest;
begin
  md5 := TLbMD5.Create(Nil);
  md5.HashFile(strNomeArq);
  md5.GetDigest(digest);
  Result := BufferToHex(digest, SizeOf(digest));
  FreeAndNil(md5);
end;

function fRetHashString(strString: String): String;
  Var
    md5: TLbMD5;
    digest: TMD5Digest;
begin
  md5 := TLbMD5.Create(Nil);
  md5.HashString(strString);
  md5.GetDigest(digest);
  Result := BufferToHex(digest, SizeOf(digest));
  FreeAndNil(md5);
end;

{*************************************************************}
{* FORMATA O NUMERICO, TROCANDO VIRGULA POR PONTO            *}
{*********************************************OUT/2009***[AM]*}
function fFloatToStrPonto(valor: double; inte,deci: integer): string;
begin
  Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inte,deci),',','.');
end;

{*************************************************************}
{* FORMATA O NUMERICO, TROCANDO PONTO POR VIRGULA            *}
{*********************************************OUT/2009***[AM]*}
function fFloatToStrVirgula(valor: double; inte,deci: integer): string;
begin
  Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inte,deci),'.',',');
end;

function fArquivoRetornoTxtBemaFI32: String;
  Var
    iniBemaFI32: TIniFile;
    strBemaFI32: String;
begin
  strBemaFI32 := '';

  If FileExists('C:\WINDOWS\system32\BemaFI32.ini') Then
    strBemaFI32 := 'C:\WINDOWS\system32\BemaFI32.ini'

  Else If FileExists(fCfgSis('DIRINI') + '\BemaFI32.ini') Then
    strBemaFI32 := fCfgSis('DIRINI') + '\BemaFI32.ini'

  Else If FileExists(ExtractFilePath(Application.ExeName) + 'BemaFI32.ini') Then
    strBemaFI32 := ExtractFilePath(Application.ExeName) + 'BemaFI32.ini';

  If Not fEmptyStr(strBemaFI32) Then
  Begin
    Try
      iniBemaFI32 := TIniFile.Create(strBemaFI32);
      Result := iniBemaFI32.ReadString('Sistema', 'Path', 'C:\') + '\RETORNO.TXT';
    Finally
      FreeAndNil(iniBemaFI32);
    End;
  End
  Else
    Result := 'C:\RETORNO.TXT';

end;


{procedure pLocksTravados(blnPerRem, blnMostraVazio: Boolean);
Begin

  Try
    pCriarFormularios(TfrmRelacaoLocks,frmRelacaoLocks);
    frmRelacaoLocks.blnPerRem := blnPerRem;

    If frmRelacaoLocks.fCarregaLocks Or blnMostraVazio Then
      frmRelacaoLocks.ShowModal;

  Except
    pMensagensErro('','');
  End;
  pFreeAndNil(frmRelacaoLocks);

End;
 }
procedure pDefineLayoutImpressao(strEspecie: String; Var strColRel, str40ColS: String;
  strEntFut: String);

  function fLayoutEntregaFutura: Boolean;
    Var
      strLayFut: String;
  begin
    Result := False;

    If (strEntFut <> 'S') Then
      Exit;

    strLayFut := fArqIni(0, 'ENTFUT', strEspecie, '');
    If (Not fEmptyStr(strLayFut)) Then
    Begin
      Result := True;
      strColRel := AnsiUpperCase(strLayFut);

      If strColRel = '40S' Then
      Begin
        strColRel := '40';
        str40ColS := 'S';
      End;
    End;
  end;
begin
  strColRel := '';
  str40ColS := '';

  If fEmptyStr(strEntFut) Then
    strEntFut := 'N';

  If Not fLayoutEntregaFutura Then
  Begin
    If (Pos(strEspecie, VS_strEsp80c) > 0) Then
      strColRel := '80'
    Else If (Pos(strEspecie, fCfgSis('ESP40C')) > 0) Then
      strColRel := '40'
    Else If (Pos(strEspecie, fCfgSis('ESP30C')) > 0) Then
      strColRel := '30'
    {*******************************************}
    {* IMPRESSAO 40 COLUNAS FAST REPORT        *}
    {****************************************AC*}
    Else If (Pos(strEspecie, VS_strEsp40s) > 0) Then
      Begin
        strColRel := '40';
        str40ColS := 'S';
      End
    Else If (fCfgSis('MODIMP') = '1') Then
      strColRel := '40'
    Else If (fCfgSis('MODIMP') = '2') Then
      strColRel := '80'
    Else If (fCfgSis('MODIMP') = '3') Then
      strColRel := '30'
    {*******************************************}
    {* IMPRESSAO 40 COLUNAS FAST REPORT        *}
    {****************************************AC*}
    Else If (fCfgSis('MODIMP') = '4') Then
      Begin
        strColRel := '40';
        str40ColS := 'S';
      End
    Else
      strColRel := '80';
  End;
end;


procedure pFreeLibraryPedidoCompra;
  Var
//    dxFinalizePedCom: procedure;
    objFree: HMODULE;
Begin
  objFree := GetModuleHandle('libPedidoDeCompra.dll');
  If (objFree <> Null) And (objFree <> 0) Then
  Begin
  //  dxFinalizePedCom := GetProcAddress(objFree, PChar('dxFinalizePedCom'));
  //  dxFinalizePedCom;
    FreeLibrary(objFree);
  End;
End;

procedure pFreeLibraryOpeRefProd;
  Var
//    dxFinalizeOrp  : procedure;
    objFree: HMODULE;
Begin
  objFree := GetModuleHandle('libOpeRefProd.dll');
  If  (objFree <> Null) And (objFree <> 0) Then
  Begin
//    dxFinalizeOrp := GetProcAddress(objFree, PChar('dxFinalizeOrp'));
//    dxFinalizeOrp;
    FreeLibrary(objFree);
  End;
End;

procedure pFreeLibraryTransfCod;
  Var
//    dxFinalizeTra  : procedure;
    objFree: HMODULE;
Begin
  objFree := GetModuleHandle('libTransfCodigo.dll');
  If  (objFree <> Null) And (objFree <> 0) Then
  Begin
//    dxFinalizeTra := GetProcAddress(objFree, PChar('dxFinalizeTra'));
//    dxFinalizeTra;
    FreeLibrary(objFree);
  End;
End;

procedure pFinalizaLibrarys;
  Var
    objFree: HMODULE;
Begin
  objFree := GetModuleHandle('libRelFatGeral.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelPedidosDeVenda.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelBancariosContabeis.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelChequesPre.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelEstatistica.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelContasAPagar.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelContasAReceber.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelLivrosFiscais.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelEstoque.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelFatEvolucaoVendas.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelFatMetas.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelFatComissao.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libRelFatVendas.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('libGNRE.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  objFree := GetModuleHandle('AutcomTinta.dll');
  If objFree <> Null Then FreeLibrary(objFree);

  pFreeLibraryPedidoCompra;
  pFreeLibraryEtiquetas;
  pFreeLibraryOpeRefProd;
  pFreeLibraryTransfCod;
End;


procedure pDestravaDupCreditoProf;
Begin
  fLock_Unlock(CHAVE_CRED_PROFISSIONAL, False, False);
End;

{************************************}
{* TRAVA PARA MÁXIMO DE UTILIZAÇÃO  *}
{* DE CRÉDITO PARA PROFISSIONAIS NO *}
{* MÊS CORRENTE                     *}
{*********************************AF*}



initialization

  blnImprime_Vencimentos_Orcamento := TRUE;
end.


