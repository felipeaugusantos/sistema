{********************************************************************}
{* Classe criada para integração com Plugins                        *}
{* Desenvolvida originalmente para integrar-se ao sub projeto BOSCH *}
{* REQUISITO: 60499                                                 *}
{* AUTOR: RENAN SERRANO                                             *}
{********************************************************************}

unit untPlugin;

interface

uses Classes, Forms, System.SysUtils, StrUtils, Menus, Windows, AdvMenus, UniClientDataSet;

type
  TPluginTelas = (pgtPrincipal, pgtDireitos);
  TProcExecutaRelatorio = reference to procedure(const strCodRel: String; arrParametros, arrValores: array of String);

  TPrcExecutaRelatorio = reference to procedure(intCodigoAtalho,
                                                intChaveDefault: integer;
                                                intChavesPossiveis: Array Of Integer;
                                                arrParametros: Array Of String;
                                                arrValores: Array Of String;
                                                SenderChamada: TObject;
                                                blnExecutarDireto: Boolean;
                                                blnExibirMensagem: Boolean;
                                                strDirAce: String;
                                                blnUsuarioLogadoDefaultVerdeVermelho: Boolean);

  TFuncExecutaValidacaoPDNotaRemessa = reference to function(const
                                                             AChaAce,
                                                             ANumPedNovo,
                                                             ANumPedAntigo,
                                                             ACodEmp,
                                                             AHubMkp : String;
                                                             out
                                                             AMensagens : String) : Boolean;

  TFuncExecutaFulfillmentMovimentaEstoqueFisicoOuExterno = reference to function(const AClaFis, AChaAce, ASigMkp : String) : Boolean;

  TProcExecutaPreValidacaoPDNotaRemessa = reference to procedure(const
                                                                 AChaAce,
                                                                 ANumPedNovo,
                                                                 ANumPedAntigo,
                                                                 ACodEmp,
                                                                 AHubMkp : String;
                                                                 var
                                                                 AItensValidacao : TUniClientDataSet);

  TProcExecutaCarregarItensNFComCodFullNotaRemessa = reference to procedure(const
                                                                 AChaAce,
                                                                 ACodEmp,
                                                                 AHubMkp : String;
                                                                 var
                                                                 AItensNF : TUniClientDataSet);

type
  TChamaPlugin = Class
  public
    class var strPathDll: String;
    class procedure pChamarPlugin(intTag: Integer);
  End;

type
  TPlugin = Class(TComponent)
  private
    FPathDll: TStringList;
    FMnuPrin: TAdvMainMenu;
    procedure pAdicionarMenu(strPathDll: String);
    procedure pLogoff(strPathDll: String);
    procedure pProcedimento(Sender: TObject);
  public
    procedure pCarregarPlugin;
    procedure pLogoffPlugins;
    constructor Create(AOwner: TComponent; mnuPrincip: TAdvMainMenu); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TPlugin }

uses
  untFuncoesSimples, untModulo, System.Generics.Collections, untFuncoesRel, untFuncoesRel2,
  TypesRel, untRelatorio,

  Fulfillment.Classes.NotaRemessaVsPedidoVenda,
  Fulfillment.RegrasMovimentacaoEstoque;

function fFulfillmentMovimentaEstoqueFisicoOuExterno(const AClaFis, AChaAce, ASigMkp : String) : Boolean;
  var
    LFulfillmentRegrasMovimentacaoEstoque : FulfillmentRegrasMovimentacaoEstoque;
begin

  LFulfillmentRegrasMovimentacaoEstoque := FulfillmentMovimentacaoEstoque(AClaFis, AChaAce, ASigMkp);

  Result := LFulfillmentRegrasMovimentacaoEstoque.MovimentaEstoqueFisico Or
            LFulfillmentRegrasMovimentacaoEstoque.MovimentaEstoqueExterno;

end;

function fValidacaoPDNotaRemessa(const AChaAce, ANumPedNovo, ANumPedAntigo, ACodEmp, AHubMkp : String; out AMensagens : String) : Boolean;
  var
    LNotaRemessaVsPedidoVenda : TNotaRemessaVsPedidoVenda;
begin

  LNotaRemessaVsPedidoVenda := TNotaRemessaVsPedidoVenda.New(AChaAce, ANumPedNovo, ANumPedAntigo, ACodEmp, AHubMkp);

  Try

    LNotaRemessaVsPedidoVenda.Executar;
    Result := (Not LNotaRemessaVsPedidoVenda.ExisteBloqueio);

    AMensagens := LNotaRemessaVsPedidoVenda.MSG_Bloqueio.Text;

  Finally
    FreeAndNil(LNotaRemessaVsPedidoVenda);
  End;

end;

procedure pPreValidacaoPDNotaRemessa(const AChaAce, ANumPedNovo, ANumPedAntigo, ACodEmp, AHubMkp : String; var AItensValidacao : TUniClientDataSet);
  var
    LNotaRemessaVsPedidoVenda : TNotaRemessaVsPedidoVenda;
begin

  LNotaRemessaVsPedidoVenda := TNotaRemessaVsPedidoVenda.New(AChaAce, ANumPedNovo, ANumPedAntigo, ACodEmp, AHubMkp);

  Try

    LNotaRemessaVsPedidoVenda.PreValidacao;

    pCloneDataSet(AItensValidacao, LNotaRemessaVsPedidoVenda.ItensValidacao);

  Finally
    FreeAndNil(LNotaRemessaVsPedidoVenda);
  End;

end;

procedure pCarregarItensNFComCodFullNotaRemessa(const AChaAce, ACodEmp, AHubMkp : String; var AItensNF : TUniClientDataSet);
  var
    LNotaRemessaVsPedidoVenda : TNotaRemessaVsPedidoVenda;
begin
  LNotaRemessaVsPedidoVenda := TNotaRemessaVsPedidoVenda.New(AChaAce, '', '', ACodEmp, AHubMkp);
  Try
    LNotaRemessaVsPedidoVenda.CarregarItensNFComCodFull;
    pCloneDataSet(AItensNF, LNotaRemessaVsPedidoVenda.ItensNF);
  Finally
    FreeAndNil(LNotaRemessaVsPedidoVenda);
  End;
end;

procedure pExecutaRelatorio(const strCodRel: String; arrParametros, arrValores: array of String);
var
  LIndex: Integer;
  arrMultiSelecao: array of String;
begin
  SetLength(arrMultiSelecao, Length(arrParametros));
  For LIndex := Low(arrMultiSelecao) To High(arrMultiSelecao) Do arrMultiSelecao[LIndex] := 'N';
  TRelatorio.pAtualizarParametrosRelatorio(strCodRel, strLoginUsuarioLogado, arrParametros, arrValores, arrMultiSelecao);
  TRelatorio.pExecutaRelatorio(strCodRel);
end;

procedure prcExecutaRelatorio(intCodigoAtalho,
                              intChaveDefault: integer;
                              intChavesPossiveis: Array Of Integer;
                              arrParametros: Array Of String;
                              arrValores: Array Of String;
                              SenderChamada: TObject;
                              blnExecutarDireto: Boolean;
                              blnExibirMensagem: Boolean;
                              strDirAce: String;
                              blnUsuarioLogadoDefaultVerdeVermelho: Boolean);
begin
  TRelatorio.pExecutaRelatorio(intCodigoAtalho,
                               intChaveDefault,
                               intChavesPossiveis,
                               arrParametros,
                               arrValores,
                               SenderChamada,
                               nil,
                               blnExecutarDireto,
                               blnExibirMensagem,
                               strDirAce,
                               blnUsuarioLogadoDefaultVerdeVermelho);
end;

constructor TPlugin.Create(AOwner: TComponent; mnuPrincip: TAdvMainMenu);
begin
  inherited Create(AOwner);
  FPathDll := TStringList.Create;
  FMnuPrin := mnuPrincip;
end;

procedure TPlugin.pCarregarPlugin;
  Var
    srcArquivo : TSearchRec;
    intAchou : Integer;
    strPath : String;
    intCnt : Integer;
Begin
  FPathDll.Clear;
  strPath := ExtractFilePath(Application.ExeName);
  Try
    intAchou := FindFirst(strPath + '*.dll', faArchive, srcArquivo);
    If (intAchou = 0) Then
    Begin
      Repeat
        If (Pos('libPlugin', srcArquivo.Name) > 0) Then
        Begin
          FPathDll.Add(strPath + srcArquivo.Name);
        End;
      Until FindNext(srcArquivo) <> 0;

      If FPathDll.Count > 0 Then
      Begin
        For intCnt := 0 To FPathDll.Count-1 Do
        Begin
          pAdicionarMenu(FPathDll.Strings[intCnt]);
        End;
      End;
    End;
  Finally
    System.SysUtils.FindClose(srcArquivo);
  End;
end;

procedure TPlugin.pLogoff(strPathDll: String);
  Var
    HandleDll      : THandle;
    fManterAtivo   : function: Boolean; StdCall;
    pLogoff        : procedure(dctDados: TDictionary<String, String>); stdcall;
    blnManterAtivo : Boolean;
    dctDados       : TDictionary<String, String>;
begin

  If FileExists(strPathDll) Then
  Begin

    HandleDll      := 0;
    blnManterAtivo := False;

    Try

      HandleDll := LoadLibrary(PChar(strPathDll));
      pLogoff   := GetProcAddress(HandleDll, PChar('pLogoff'));

      if Assigned(pLogoff) then
      begin

        dctDados := TDictionary<String, String>.Create;

        Try
          dctDados.Add('CODEMP', VS_strCodEmp);
          dctDados.Add('CODOPE', strLoginUsuarioLogado);
          pLogoff(dctDados);
        Finally
          FreeAndNil(dctDados);
        End;

      end;

      fManterAtivo := GetProcAddress(HandleDll, 'fManterAtivo');
      if Assigned(fManterAtivo) then
        blnManterAtivo := fManterAtivo;

    Finally
      if not blnManterAtivo then
        FreeLibrary(HandleDll);
    End;

  End;

end;

procedure TPlugin.pLogoffPlugins;
  Var
    intCnt     : Integer;
Begin
  If FPathDll.Count > 0 Then
  Begin
    For intCnt := 0 To FPathDll.Count-1 Do
    Begin
      pLogoff(FPathDll.Strings[intCnt]);
    End;
  End;
end;

destructor TPlugin.Destroy;
begin
  FreeAndNil(FPathDll);
  inherited;
end;

procedure TPlugin.pAdicionarMenu(strPathDll: String);
  Var
    HandleDll : THandle;
    fNomePlugin : function:String; StdCall;
    fManterAtivo: function: Boolean; StdCall;
    pPreCarregar: procedure(dctDados: TDictionary<String, String>); stdcall;
    blnManterAtivo: Boolean;
    strNomPlu : String;
    mnuPlugin : TMenuItem;
    mnuDirPlugin : TMenuItem;
    intIndex : Integer;

    dctDados: TDictionary<String, String>;
begin
  If FileExists(strPathDll) Then
  Begin
    HandleDll := 0;
    blnManterAtivo := False;
    Try
      HandleDll := LoadLibrary(PChar(strPathDll));

      pPreCarregar := GetProcAddress(HandleDll, PChar('pPreCarregar'));
      if Assigned(pPreCarregar) then
      begin
        dctDados := TDictionary<String, String>.Create;
        dctDados.Add('CODEMP', VS_strCodEmp);
        dctDados.Add('CODOPE', strLoginUsuarioLogado);

        pPreCarregar(dctDados);
        FreeAndNil(dctDados);
      end;

      fNomePlugin := GetProcAddress(HandleDll, 'fNomePlugin');
      Sleep(100);
      strNomPlu := '';
      if Assigned(fNomePlugin) then
        strNomPlu := fNomePlugin;

      fManterAtivo := GetProcAddress(HandleDll, 'fManterAtivo');
      if Assigned(fManterAtivo) then
        blnManterAtivo := fManterAtivo;

      If (Trim(strNomPlu) <> '') Then
      Begin
        intIndex := FMnuPrin.Items.Find('Útil').MenuIndex;

        If (intIndex >= 0) Then
        Begin
          // Menu Principal
          FMnuPrin.BeginUpDate;
          mnuPlugin := TMenuItem.Create(FMnuPrin);
          mnuPlugin.Caption := strNomPlu;
          mnuPlugin.Hint := '0_' + ExtractFileName(strPathDll);
          mnuPlugin.Name := 'mnu0' + fTiraCaracEspeciais(ExtractFileName(strPathDll), True, True, True);
          mnuPlugin.Tag := 0;
          mnuPlugin.OnClick := pProcedimento;

          FMnuPrin.Items.Insert(intIndex + 1, mnuPlugin);
          FMnuPrin.EndUpDate;

          If (FMnuPrin.Owner.FindComponent('mnuSeguranca') <> Nil) Then
          Begin
            // Menu dos Direitos
            FMnuPrin.BeginUpDate;
            mnuDirPlugin := TMenuItem.Create(FMnuPrin);
            mnuDirPlugin.Caption := 'Direitos de Acesso (' + strNomPlu + ')';
            mnuDirPlugin.Hint := '1_' + ExtractFileName(strPathDll);
            mnuDirPlugin.Name := 'mnu1' + fTiraCaracEspeciais(ExtractFileName(strPathDll), True, True, True);
            mnuDirPlugin.Tag := 1;
            mnuDirPlugin.OnClick := pProcedimento;

            TMenuItem(FMnuPrin.Owner.FindComponent('mnuSeguranca')).Add(mnuDirPlugin);

            FMnuPrin.EndUpDate;
          End;
        End;
      End;
    Finally
      if not blnManterAtivo then
        FreeLibrary(HandleDll);
    End;
  End;
end;

procedure TPlugin.pProcedimento(Sender: TObject);
begin
  TChamaPlugin.strPathDll := ExtractFilePath(Application.ExeName) + Copy(TMenuItem(Sender).Hint, 3, Length(TMenuItem(Sender).Hint));
  TChamaPlugin.pChamarPlugin(TMenuItem(Sender).Tag);
end;

{ TChamaPlugin }

class procedure TChamaPlugin.pChamarPlugin(intTag: Integer);
  Var
    HandleDll : THandle;
    pSetProcExecutaRelatorio: procedure(AProc: TProcExecutaRelatorio); stdcall;
    pSetPrcExecutaRelatorio: procedure(AProc: TPrcExecutaRelatorio); stdcall;
    pSetFuncExecutaValidacaoPDNotaRemessa: function(AFunc: TFuncExecutaValidacaoPDNotaRemessa) : Boolean; stdcall;
    pSetFuncExecutaFulfillmentMovimentaEstoqueFisicoOuExterno: function(AFunc : TFuncExecutaFulfillmentMovimentaEstoqueFisicoOuExterno) : Boolean; StdCall;
    pSetProcExecutaPreValidacaoPDNotaRemessa: procedure(AProc: TProcExecutaPreValidacaoPDNotaRemessa); stdcall;
    pSetProcExecutaCarregarItensNFComCodFullNotaRemessa: procedure(AProc: TProcExecutaCarregarItensNFComCodFullNotaRemessa); stdcall;
    pProcedure : procedure(strParam, strUsername, strPassword, strServer, strDataBase, strPort, strCodEmp, strUsuLog: String); StdCall;
    strParam : String;
begin
  If FileExists(strPathDll) Then
  Begin
    HandleDll := 0;
    Try
      HandleDll := LoadLibrary(PChar(strPathDll));

      pProcedure := GetProcAddress(HandleDll, 'pPlugin');
      pSetProcExecutaRelatorio := GetProcAddress(HandleDll, 'pSetProcExecutaRelatorio');
      pSetPrcExecutaRelatorio := GetProcAddress(HandleDll, 'pSetPrcExecutaRelatorio');
      pSetFuncExecutaValidacaoPDNotaRemessa := GetProcAddress(HandleDll, 'pSetFuncExecutaValidacaoPDNotaRemessa');
      pSetFuncExecutaFulfillmentMovimentaEstoqueFisicoOuExterno := GetProcAddress(HandleDll, 'pSetFuncExecutaFulfillmentMovimentaEstoqueFisicoOuExterno');
      pSetProcExecutaPreValidacaoPDNotaRemessa := GetProcAddress(HandleDll, 'pSetProcExecutaPreValidacaoPDNotaRemessa');
      pSetProcExecutaCarregarItensNFComCodFullNotaRemessa := GetProcAddress(HandleDll, 'pSetProcExecutaCarregarItensNFComCodFullNotaRemessa');

      If Assigned(pSetProcExecutaRelatorio) Then
      Begin
        Try
          pSetProcExecutaRelatorio(pExecutaRelatorio);
        Except
          Sleep(100); //do nothing
        End;
      End;

      If Assigned(pSetPrcExecutaRelatorio) Then
      Begin
        Try
          pSetPrcExecutaRelatorio(prcExecutaRelatorio);
        Except
          Sleep(100); //do nothing
        End;
      End;

      If Assigned(pSetFuncExecutaValidacaoPDNotaRemessa) Then
      Begin
        Try
          pSetFuncExecutaValidacaoPDNotaRemessa(fValidacaoPDNotaRemessa);
        Except
          Sleep(100); //do nothing
        End;
      End;

      If Assigned(pSetFuncExecutaFulfillmentMovimentaEstoqueFisicoOuExterno) Then
      Begin
        Try
          pSetFuncExecutaFulfillmentMovimentaEstoqueFisicoOuExterno(fFulfillmentMovimentaEstoqueFisicoOuExterno);
        Except
          Sleep(100); //do nothing
        End;
      End;

      If Assigned(pSetProcExecutaPreValidacaoPDNotaRemessa) Then
      Begin
        Try
          pSetProcExecutaPreValidacaoPDNotaRemessa(pPreValidacaoPDNotaRemessa);
        Except
          Sleep(100); //do nothing
        End;
      End;

      If Assigned(pSetProcExecutaCarregarItensNFComCodFullNotaRemessa) Then
      Begin
        Try
          pSetProcExecutaCarregarItensNFComCodFullNotaRemessa(pCarregarItensNFComCodFullNotaRemessa);
        Except
          Sleep(100); //do nothing
        End;
      End;

      Case TPluginTelas(intTag) Of
        pgtPrincipal: strParam := 'Principal';
        pgtDireitos: strParam := 'Direitos' ;
      End;

      If Assigned(pProcedure) Then
      Begin
        With frmModulo Do
          pProcedure(strParam, Database.UserName, Database.Password,
                     Database.Server, Database.DataBase, IntToStr(Database.Port),
                     VS_strCodEmp, strLoginUsuarioLogado);
      End;
    Finally
      FreeLibrary(HandleDll);
    End;
  End;
end;

end.
