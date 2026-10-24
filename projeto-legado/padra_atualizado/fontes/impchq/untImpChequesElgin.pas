unit untImpChequesElgin;

interface

uses Windows, untImpCheques, SysUtils, StrUtils,Forms;

Type
  TImpChequesElgin = class(TImpCheques)
  private
    NSCheq_ChangePort: function (Valor : integer): Integer; stdcall;
    cmdsSendBank     : function (sBank: LPSTR): integer; stdcall;
    cmdsSendCity     : function (sCidade: LPSTR): integer; stdcall;
    cmdsSendDate     : function (iZerow : integer; szDay: LPSTR; szMonth: LPSTR; szYear: LPSTR): integer; stdcall;
    cmdsSendName     : function (szName: LPSTR): integer; stdcall;
    cmdsSendNumCheque: function (szNCheq: LPSTR): integer; stdcall;
    cmdsSendValor    : function (szValor: LPSTR): integer; stdcall;
    cmdsSendFormFeed : function: integer; stdcall;
    dllComputaEmissao: function (Cheque: LPSTR; Bank: LPSTR; ValorClean: LPSTR; Dia: LPSTR; Mes: LPSTR; Ano: LPSTR; Favor: LPSTR): integer; stdcall;

    strPatDll: String;
    HandleDLL: Cardinal;

    procedure pVerErro(Const intRetorno: Integer; Const strMensagem: String);
  public
    procedure pImprimirCheque; override;
    procedure pInicializaDLL; override;
  End;

implementation

uses untFuncoesSimples, untConstantes, untTypesSistema;

{ TImpChequesElgin }

procedure TImpChequesElgin.pImprimirCheque;
  Const
    MSG_ERRO = 'Verifique se a impressora está ligada e o cheque posicionado.';
  Var
    intPorta: Integer;
    strDia,
    strMes,
    strAno,
    strValor: LPSTR;

    wrdAno,
    wrdMes,
    wrdDia: Word;
begin
  inherited;
  intPorta := StrToIntDef(RightStr(strPorta, 1), 1);
  Dec(intPorta);

  strNumChq := fStrZero(RightStr(strNumChq, 6), 6);
  strNomCid := LeftStr(strNomCid, 20);

  DecodeDate(dtaDtaChq, wrdAno, wrdMes, wrdDia);
  strDia := PAnsiChar(AnsiString(fStrZero(IntToStr(wrdDia), 2)));
  strMes := PAnsiChar(AnsiString(fStrZero(IntToStr(wrdMes), 2)));
  strAno := PAnsiChar(RightStr(AnsiString(IntToStr(wrdAno)), 2));

  strValor := PAnsiChar(AnsiString(AnsiReplaceStr(FloatToStrF(fltValChq, ffFixed, 12, 2), ',', '')));
  strValor := PAnsiChar(AnsiString(fStrZero(String(StrPas(strValor)), 14)));

  pVerErro(NSCheq_ChangePort(intPorta), 'Erro conectar com a ImpreCheq. Verifique a conexão na porta ' + strPorta + '.');

  pVerErro(cmdsSendBank(PAnsiChar(AnsiString(strNumBco))), 'Erro ao enviar o banco ' + strNumBco + '. ' + MSG_ERRO);

  pVerErro(cmdsSendCity(PAnsiChar(AnsiString(strNomCid))), 'Erro ao enviar a cidade ' + strNomCid + '. ' + MSG_ERRO);

  pVerErro(cmdsSendDate(0, strDia, strMes, strAno), 'Erro ao enviar a data ' + DateToStr(dtaDtaChq) + '. ' + MSG_ERRO);

  pVerErro(cmdsSendName(PAnsiChar(AnsiString(strNomFav))), 'Erro ao enviar o nome do favorecido ' + strNomFav + '. ' + MSG_ERRO);

  pVerErro(cmdsSendNumCheque(PAnsiChar(AnsiString(strNumChq))), 'Erro ao enviar o cheque ' + strNumChq + '. ' + MSG_ERRO);

  pVerErro(cmdsSendValor(strValor), 'Erro ao enviar o valor ' + FloatToStrF(fltValChq, ffFixed, 12, 2) + '. ' + MSG_ERRO);

  cmdsSendFormFeed;

  //pVerErro(dllComputaEmissao(PChar(strNumChq), PChar(strNumBco), strValor, strDia,
  //  strMes, strAno, PChar(strNomFav)), 'Erro ao concluir emissão. ' + MSG_ERRO);

end;

procedure TImpChequesElgin.pInicializaDLL;
begin
  inherited;
  strPorta  := PChar(fArqIniLocal(0, 'ELGIN', 'PORTA', 'COM1', ExtractFilePath(Application.ExeName)+'opcoes_impchq.ini'));
  strPatDll := fArqIniLocal(0, 'ELGIN', 'PATDLL', '', ExtractFilePath(Application.ExeName)+'opcoes_impchq.ini');

  HandleDLL := LoadLibrary(PChar(strPatDLL));

  If (HandleDLL = 0) Then
    Raise ExceptionAutCom .Create('Não consegui carregar a DLL nscheq.dll.');

  NSCheq_ChangePort := GetProcAddress(HandleDLL, PChar('NSCheq_ChangePort'));
  cmdsSendBank      := GetProcAddress(HandleDLL, PChar('cmdsSendBank'));
  cmdsSendCity      := GetProcAddress(HandleDLL, PChar('cmdsSendCity'));
  cmdsSendDate      := GetProcAddress(HandleDLL, PChar('cmdsSendDate'));
  cmdsSendName      := GetProcAddress(HandleDLL, PChar('cmdsSendName'));
  cmdsSendNumCheque := GetProcAddress(HandleDLL, PChar('cmdsSendNumCheque'));
  cmdsSendValor     := GetProcAddress(HandleDLL, PChar('cmdsSendValor'));
  cmdsSendFormFeed  := GetProcAddress(HandleDLL, PChar('cmdsSendFormFeed'));
  dllComputaEmissao := GetProcAddress(HandleDLL, PChar('dllComputaEmissao'));
end;

{************************************************}
{* ESSE TRATAMENTO EXISTE DESDE 2008 NÃO EXISTE *}
{* DOCUMENTAÇÃO OQUE CADA CODIGO SIGNIFICA      *}
{* ENTRETANDO QUANDO RETORNAR '4' DESCUBRI QUE  *}
{* É UMA FALHA DE COMUNICAÇÃO COM A PORTA       *}
{* FALAR PARA O CLIENTE DESATIVAR E ATIAVAR A   *}
{* PORTA QUE ESTA UTILIZANDO ********************}
{**********************************************LE}
procedure TImpChequesElgin.pVerErro(const intRetorno: Integer;
  const strMensagem: String);
begin
  If intRetorno <> 0 Then
    Raise ExceptionAutCom.Create(#13+'Erro Cod.: ' + IntToStr(intRetorno)+#13+strMensagem);
end;

end.
