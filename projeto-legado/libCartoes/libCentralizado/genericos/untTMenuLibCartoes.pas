unit untTMenuLibCartoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.StrUtils,
  Vcl.StdCtrls, System.Rtti,

  untILibCartoesFactory, untILibCartoesWrapper, untTLibCartoesFuncoes,
  untLibCartoesTelasAbertas, untLibCartoesInterfacesTipos,
  untLibCartoesTiposCompartilhados;

Type
  TMenuLibCartoes = class(TObject)
  private
    FMenuImportacaoCartoes,
    FMenuConciliacaoCartoes,
    FMenuAntecipacaoCartoes,
    FMenuImportacaoRecebiveis,
    FMenuBaixaRecebiveisMkt,
    FMenuExclusaoArquivosImportados,
    FMenuExportacaoCartoes            : TCustomMenuItemCartoes;

    class procedure ImportarLibCartoesDLL(AArquivoDLL: String;
                                          ALayoutAPI: Boolean);

    class procedure ConciliarLibCartoesDLL(AArquivoDLL: String;
                                           ALayoutAPI: Boolean);

    class procedure AnteciparLibCartoesDLL(AArquivoDLL: String;
                                           ALayoutAPI: Boolean);

    class procedure BaixarRecebiveisMktLibCartoesDLL(AArquivoDLL: String;
                                                     ALayoutAPI: Boolean);

    class procedure ExclusaoLibCartoesDLL(AArquivoDLL: String;
                                          ALayoutAPI: Boolean);

    class procedure ExportacaoLibCartoesDLL(AArquivoDLL: String;
                                           ALayoutAPI: Boolean);

    class procedure LiberaLibMemoria(Var AHandleLibCartoes: THandle);

    procedure AdicionaSubMenu(var AMenuPrincipal: TCustomMenuItemCartoes;
                              ANomeMenu,
                              ANomeDLL,
                              ALayout,
                              ADescricao: String;
                              AHintPersonalizado: String = '');

  public
    constructor Create;
    destructor Destroy; override;

    procedure CriarMenus;

    function RetornaMenusImportacao: TCustomMenuItemCartoes;
    function RetornaMenusConciliacao: TCustomMenuItemCartoes;
    function RetornaMenusAntecipacao: TCustomMenuItemCartoes;
    function RetornaMenusImportacaoRecebiveisMkt: TCustomMenuItemCartoes;
    function RetornaMenusBaixaRecebiveisMkt: TCustomMenuItemCartoes;
    function RetornaMenusExclusaoArquivosImportados: TCustomMenuItemCartoes;
    function RetornaMenusExportacaoArquivos: TCustomMenuItemCartoes;

    class procedure OnClickImportacao(Sender: TObject);
    class procedure OnClickConciliacao(Sender: TObject);
    class procedure OnClickAntecipacao(Sender: TObject);
    class procedure OnClickBaixaRecebiveisMkt(Sender: TObject);
    class procedure OnClickExclusao(Sender: TObject);
    class procedure OnClickExportacao(Sender: TObject);
    class procedure OnClickConfirmacaoCartoes;
  end;

implementation
Uses untLibCartoesConfirmacaoDeCartoes;

{ TMenuLibCartoes }

procedure TMenuLibCartoes.AdicionaSubMenu(var AMenuPrincipal: TCustomMenuItemCartoes;
  ANomeMenu, ANomeDLL, ALayout, ADescricao, AHintPersonalizado: String);
  Var
    LMenuAdicionar: TCustomMenuItemCartoes;
begin
  If AHintPersonalizado.IsEmpty Then
    AHintPersonalizado := ANomeMenu;

  LMenuAdicionar := TCustomMenuItemCartoes.Create(AMenuPrincipal);

  LMenuAdicionar.Name := ANomeMenu;
  LMenuAdicionar.Caption := ADescricao;
  LMenuAdicionar.Hint := AHintPersonalizado;
  LMenuAdicionar.OnClick := Nil;
  LMenuAdicionar.Projeto := 'libCartoesAutcom.dll';
  LMenuAdicionar.LibAcesso := ANomeDLL;
  LMenuAdicionar.Layout := ALayout;

  AMenuPrincipal.Add(LMenuAdicionar);
end;

class procedure TMenuLibCartoes.AnteciparLibCartoesDLL(AArquivoDLL: String;
  ALayoutAPI: Boolean);
  Var
    LHandleLibCartoes: THandle;

    LEmpresa,
    LCaminhoDLL: String;

    dxInitialize: procedure; StdCall;
    InicializaObjetoLibCartoes: procedure(AObjetoLibCartoes: ILibCartoes); StdCall;
    pAtualizaObjetoTelasAbertas: procedure(ATelaAbertas: ITelasAbertas); StdCall;
    SetStyleAutcom: procedure(AAutcomModoClassico: Boolean); StdCall;

    AntecipacaoCartoes: procedure(AAplicacao: HWND; ANomeEmpresa: String); StdCall;
begin
  LCaminhoDLL := ExtractFilePath(Application.ExeName) + 'libCartoes\' + AArquivoDLL;
  If Not FileExists(LCaminhoDLL) Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO','O arquivo ' + AArquivoDLL + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!',['&OK']);
    Exit;
  End;

  LEmpresa := Concat(VS_FuncoesExternas.fIRetEmpresaLogada, ' - ',
                     TLibCartoesFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada));

  LHandleLibCartoes := 0;
  Try
    LHandleLibCartoes := SafeLoadLibrary(PChar(LCaminhoDLL));

    dxInitialize := GetProcAddress(LHandleLibCartoes, 'dxInitialize');
    dxInitialize;

    InicializaObjetoLibCartoes := GetProcAddress(LHandleLibCartoes, pChar('InicializaObjetoLibCartoes'));
    InicializaObjetoLibCartoes(TLibCartoesFactory.Get);

    SetStyleAutcom := GetProcAddress(LHandleLibCartoes, pChar('SetStyleAutcom'));
    SetStyleAutcom(VS_FuncoesExternas.fIExecutandoModoClassico);

    pAtualizaObjetoTelasAbertas := GetProcAddress(LHandleLibCartoes, pChar('pAtualizaObjetoTelasAbertas'));
    If VS_FuncoesExternas.fIGetObjetoTelasAbertas <> Nil Then
      pAtualizaObjetoTelasAbertas(VS_FuncoesExternas.fIGetObjetoTelasAbertas);

    AntecipacaoCartoes := GetProcAddress(LHandleLibCartoes, pChar('AntecipacaoCartoes'));
    AntecipacaoCartoes(Application.Handle, LEmpresa);
  Finally
    LiberaLibMemoria(LHandleLibCartoes);
  End;
end;

class procedure TMenuLibCartoes.BaixarRecebiveisMktLibCartoesDLL(
  AArquivoDLL: String; ALayoutAPI: Boolean);
  Var
    LHandleLibCartoes: THandle;

    LEmpresa,
    LCaminhoDLL: String;

    dxInitialize: procedure; StdCall;
    InicializaObjetoLibCartoes: procedure(AObjetoLibCartoes: ILibCartoes); StdCall;
    pAtualizaObjetoTelasAbertas: procedure(ATelaAbertas: ITelasAbertas); StdCall;
    SetStyleAutcom: procedure(AAutcomModoClassico: Boolean); StdCall;

    BaixarRecebiveisMktArquivo: procedure; StdCall;
begin
  LCaminhoDLL := ExtractFilePath(Application.ExeName) + 'libCartoes\' + AArquivoDLL;
  If Not FileExists(LCaminhoDLL) Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO','O arquivo ' + AArquivoDLL + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!',['&OK']);
    Exit;
  End;

  LEmpresa := Concat(VS_FuncoesExternas.fIRetEmpresaLogada, ' - ',
                     TLibCartoesFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada));

  LHandleLibCartoes := 0;
  Try
    LHandleLibCartoes := SafeLoadLibrary(PChar(LCaminhoDLL));

    dxInitialize := GetProcAddress(LHandleLibCartoes, 'dxInitialize');
    dxInitialize;

    InicializaObjetoLibCartoes := GetProcAddress(LHandleLibCartoes, pChar('InicializaObjetoLibCartoes'));
    InicializaObjetoLibCartoes(TLibCartoesFactory.Get);

    SetStyleAutcom := GetProcAddress(LHandleLibCartoes, pChar('SetStyleAutcom'));
    SetStyleAutcom(VS_FuncoesExternas.fIExecutandoModoClassico);

    pAtualizaObjetoTelasAbertas := GetProcAddress(LHandleLibCartoes, pChar('pAtualizaObjetoTelasAbertas'));
    If VS_FuncoesExternas.fIGetObjetoTelasAbertas <> Nil Then
      pAtualizaObjetoTelasAbertas(VS_FuncoesExternas.fIGetObjetoTelasAbertas);

    BaixarRecebiveisMktArquivo := GetProcAddress(LHandleLibCartoes, pChar('BaixarRecebiveisMktArquivo'));
    BaixarRecebiveisMktArquivo;
    Exit;
  Finally
    LiberaLibMemoria(LHandleLibCartoes);
  End;
end;

class procedure TMenuLibCartoes.ConciliarLibCartoesDLL(AArquivoDLL: String;
  ALayoutAPI: Boolean);
  Var
    LHandleLibCartoes: THandle;

    LEmpresa,
    LCaminhoDLL: String;

    dxInitialize: procedure; StdCall;
    InicializaObjetoLibCartoes: procedure(AObjetoLibCartoes: ILibCartoes); StdCall;
    pAtualizaObjetoTelasAbertas: procedure(ATelaAbertas: ITelasAbertas); StdCall;
    SetStyleAutcom: procedure(AAutcomModoClassico: Boolean); StdCall;

    ConciliacaoCartoesArquivo: procedure; StdCall;
    ConciliacaoCartoesApi: procedure; StdCall;
begin
  LCaminhoDLL := ExtractFilePath(Application.ExeName) + 'libCartoes\' + AArquivoDLL;
  If Not FileExists(LCaminhoDLL) Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO','O arquivo ' + AArquivoDLL + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!',['&OK']);
    Exit;
  End;

  LEmpresa := Concat(VS_FuncoesExternas.fIRetEmpresaLogada, ' - ',
                     TLibCartoesFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada));

  LHandleLibCartoes := 0;
  Try
    LHandleLibCartoes := SafeLoadLibrary(PChar(LCaminhoDLL));

    dxInitialize := GetProcAddress(LHandleLibCartoes, 'dxInitialize');
    dxInitialize;

    InicializaObjetoLibCartoes := GetProcAddress(LHandleLibCartoes, pChar('InicializaObjetoLibCartoes'));
    InicializaObjetoLibCartoes(TLibCartoesFactory.Get);

    SetStyleAutcom := GetProcAddress(LHandleLibCartoes, pChar('SetStyleAutcom'));
    SetStyleAutcom(VS_FuncoesExternas.fIExecutandoModoClassico);

    pAtualizaObjetoTelasAbertas := GetProcAddress(LHandleLibCartoes, pChar('pAtualizaObjetoTelasAbertas'));
    If VS_FuncoesExternas.fIGetObjetoTelasAbertas <> Nil Then
      pAtualizaObjetoTelasAbertas(VS_FuncoesExternas.fIGetObjetoTelasAbertas);

    If Not ALayoutAPI Then
    Begin
      ConciliacaoCartoesArquivo := GetProcAddress(LHandleLibCartoes, pChar('ConciliacaoCartoesArquivo'));
      ConciliacaoCartoesArquivo;
      Exit;
    End;

    ConciliacaoCartoesApi := GetProcAddress(LHandleLibCartoes, pChar('ConciliacaoCartoesApi'));
    ConciliacaoCartoesApi;
  Finally
    LiberaLibMemoria(LHandleLibCartoes);
  End;
end;

constructor TMenuLibCartoes.Create;
begin
  CriarMenus;
end;

procedure TMenuLibCartoes.CriarMenus;
begin
  {*mnuImportacaoCartoes*}
  FMenuImportacaoCartoes := TCustomMenuItemCartoes.Create(Nil);
  FMenuImportacaoCartoes.Clear;
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpRedeCard', 'libCartoesRedeCard.dll', 'Arq', 'Importação RedeCard Arquivos', 'libIntegracaoCartoes');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpRedeCardAPI', 'libCartoesRedeCard.dll', 'API', 'Importação RedeCard Online');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpSipag', 'libCartoesSipag.dll', 'Arq', 'Importação Sipag');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpYapay', 'libCartoesYapay.dll', 'Arq', 'Importação Yapay');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpPagSeguro', 'libCartoesPagSeguro.dll', 'Arq', 'Importação PagSeguro Arquivos');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpPagSeguroAPI', 'libCartoesPagSeguro.dll', 'API', 'Importação PagSeguro Online');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpMobbuyAPI', 'libCartoesMobbuy.dll', 'API', 'Importação Sempre Pronto Online');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpSafrapay', 'libCartoesSafrapay.dll', 'Arq', 'Importação Safrapay');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpCielo', 'libCartoesCielo.dll', 'Arq', 'Importação Cielo');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpStone', 'libCartoesStone.dll', 'API', 'Importação Stone');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpSicredi', 'libCartoesSicredi.dll', 'Arq', 'Importação Sicredi');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpGetNet', 'libCartoesGetnet.dll', 'Arq', 'Importação GetNet');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImportacaoEquals', 'libCartoesEquals.dll', 'Arq', 'Importação Equals', 'libIntegracaoEquals');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpFiservBin', 'libCartoesFiservBin.dll', 'Arq', 'Importação Fiserv-Bin');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpPagarMe', 'libCartoesPagarMe.dll', 'API', 'Importação Pagar.Me');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpBanrisul', 'libCartoesBanrisul.dll', 'Arq', 'Importação Banrisul');
  AdicionaSubMenu(FMenuImportacaoCartoes, 'mnuImpGranito', 'libCartoesGranito.dll', 'Arq', 'Importação Granito');

  {*mnuConciliacaoCartoes*}
  FMenuConciliacaoCartoes := TCustomMenuItemCartoes.Create(Nil);
  FMenuConciliacaoCartoes.Clear;
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoRedeCard', 'libCartoesRedeCard.dll', 'Arq', 'Conciliação RedeCard Arquivos');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoRedeCardAPI', 'libCartoesRedeCard.dll', 'API', 'Conciliação RedeCard Online');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoSipag', 'libCartoesSipag.dll', 'Arq', 'Conciliação Sipag');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliacaoYapay', 'libCartoesYapay.dll', 'Arq', 'Conciliação Yapay');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoPagSeguro', 'libCartoesPagSeguro.dll', 'Arq', 'Conciliação PagSeguro Arquivos');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoPagSeguroAPI', 'libCartoesPagSeguro.dll', 'API', 'Conciliação PagSeguro Online');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoMobbuyAPI', 'libCartoesMobbuy.dll', 'API', 'Conciliação Sempre Pronto Online');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoSafrapay', 'libCartoesSafrapay.dll', 'Arq', 'Conciliação Safrapay');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoCielo', 'libCartoesCielo.dll', 'Arq', 'Conciliação Cielo');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoStone', 'libCartoesStone.dll', 'API', 'Conciliação Stone Online');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoSicredi', 'libCartoesSicredi.dll', 'Arq', 'Conciliação Sicredi');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoGetNet', 'libCartoesGetnet.dll', 'Arq', 'Conciliação GetNet');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoEquals', 'libCartoesEquals.dll', 'Arq', 'Conciliação Equals');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliacaoFiservBin', 'libCartoesFiservBin.dll', 'Arq', 'Conciliação Fiserv-Bin');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliaoPagarMe', 'libCartoesPagarMe.dll', 'API', 'Conciliação Pagar.Me');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliacaoBanrisul', 'libCartoesBanrisul.dll', 'Arq', 'Conciliação Banrisul');
  AdicionaSubMenu(FMenuConciliacaoCartoes, 'mnuConciliacaoGranito', 'libCartoesGranito.dll', 'Arq', 'Conciliação Granito');

  {*mnuAntecipacaoDeCartoes*}
  FMenuAntecipacaoCartoes := TCustomMenuItemCartoes.Create(Nil);
  FMenuAntecipacaoCartoes.Clear;
  {******************************************************************************************************}
  {****************             RETIRADO MENU ANTECIPACAO REDE CARD REQ. 438214          ****************}
  {**     CASO ADICIONE UMA ANTECIPACAO NOVA, RETIRAR: mnuAntecipacaoDeCartoes.Visible := False        **}
  {**                      da procedure pEscondeMenus na untPrincipal do Autcom.exe                    **}
  {***************************************************************************************************RG*}
  //AdicionaSubMenu(FMenuAntecipacaoCartoes, 'mnuAntecipacaoRedeCard', 'libCartoesRedeCard.dll', 'API', 'Antecipação RedeCard Online', 'frmAntecipacaoRedeCard');

  {*mnuImportacaoRecebiveisMkt*}
  FMenuImportacaoRecebiveis := TCustomMenuItemCartoes.Create(Nil);
  FMenuImportacaoRecebiveis.Clear;
  AdicionaSubMenu(FMenuImportacaoRecebiveis, 'mnuImpML', 'libCartoesMercadoLivre.dll', 'Arq', 'Importação Mercado Livre');
  AdicionaSubMenu(FMenuImportacaoRecebiveis, 'mnuImpShopeePay', 'libCartoesShopee.dll', 'Arq', 'Importação Shopee');
  AdicionaSubMenu(FMenuImportacaoRecebiveis, 'mnuImpMagazineLuiza', 'libCartoesMagazineLuiza.dll', 'Arq', 'Importação Magazine Luiza');
  AdicionaSubMenu(FMenuImportacaoRecebiveis, 'mnuImpB2W', 'libCartoesB2W.dll', 'Arq', 'Importação B2W');
  AdicionaSubMenu(FMenuImportacaoRecebiveis, 'mnuImpAmazon', 'libCartoesAmazon.dll', 'Arq', 'Importação Amazon');

  {*mnuBaixaRecebiveisMkt*}
  FMenuBaixaRecebiveisMkt := TCustomMenuItemCartoes.Create(Nil);
  FMenuBaixaRecebiveisMkt.Clear;
  AdicionaSubMenu(FMenuBaixaRecebiveisMkt, 'mnuConciliaoMercadoLivre', 'libCartoesMercadoLivre.dll', 'Arq', 'Conciliação/Baixa de Recebíveis Mercado Livre');
  AdicionaSubMenu(FMenuBaixaRecebiveisMkt, 'mnuConciliaoShopeePay', 'libCartoesShopee.dll', 'Arq', 'Conciliação/Baixa de Recebíveis Shopee');
  AdicionaSubMenu(FMenuBaixaRecebiveisMkt, 'mnuConciliacaoMagazileLuiza', 'libCartoesMagazineLuiza.dll', 'Arq', 'Conciliação/Baixa de Recebíveis Magazine Luiza');
  AdicionaSubMenu(FMenuBaixaRecebiveisMkt, 'mnuConciliaoB2W', 'libCartoesB2W.dll', 'Arq', 'Conciliação/Baixa de Recebíveis B2W');
  AdicionaSubMenu(FMenuBaixaRecebiveisMkt, 'mnuConciliacaoAmazon', 'libCartoesAmazon.dll', 'Arq', 'Conciliação/Baixa de Recebíveis Amazon');

  {*mnuExclusaoDeArquivosImpotados*}
  FMenuExclusaoArquivosImportados := TCustomMenuItemCartoes.Create(Nil);
  FMenuExclusaoArquivosImportados.Clear;
  AdicionaSubMenu(FMenuExclusaoArquivosImportados, 'mnuExcluirArquivoDaCielo', 'libCartoesCielo.dll', 'Arq', 'Excluir arquivo da Cielo');
  AdicionaSubMenu(FMenuExclusaoArquivosImportados, 'mnuExcluirArquivoDaGetNet', 'libCartoesGetnet.dll', 'Arq', 'Excluir arquivo da GetNet');
  AdicionaSubMenu(FMenuExclusaoArquivosImportados, 'mnuExcluirArquivoDaShopee', 'libCartoesShopee.dll', 'Arq', 'Excluir arquivo da Shopee');
  {*mnuExportacaoDeCartoes*}
  FMenuExportacaoCartoes := TCustomMenuItemCartoes.Create(Nil);
  FMenuExportacaoCartoes.Clear;
  AdicionaSubMenu(FMenuExportacaoCartoes, 'mnuExportaoEquals', 'libCartoesEquals.dll', 'Arq', 'Exportação Cartoes Equals');

end;

destructor TMenuLibCartoes.Destroy;
begin
  FreeAndNil(FMenuImportacaoCartoes);
  FreeAndNil(FMenuConciliacaoCartoes);
  FreeAndNil(FMenuAntecipacaoCartoes);
  FreeAndNil(FMenuImportacaoRecebiveis);
  FreeAndNil(FMenuBaixaRecebiveisMkt);
  FreeAndNil(FMenuExclusaoArquivosImportados);
  FreeAndNil(FMenuExportacaoCartoes);
  inherited;
end;

class procedure TMenuLibCartoes.ExclusaoLibCartoesDLL(AArquivoDLL: String;
  ALayoutAPI: Boolean);
  Var
    LHandleLibCartoes: THandle;

    LEmpresa,
    LCaminhoDLL: String;

    dxInitialize: procedure; StdCall;
    InicializaObjetoLibCartoes: procedure(AObjetoLibCartoes: ILibCartoes); StdCall;
    VerificaEstruturaTabelas: procedure; StdCall;
    pAtualizaObjetoTelasAbertas: procedure(ATelaAbertas: ITelasAbertas); StdCall;
    SetStyleAutcom: procedure(AAutcomModoClassico: Boolean); StdCall;

    ExcluirArquivosImportados: procedure(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
begin
  LCaminhoDLL := ExtractFilePath(Application.ExeName) + 'libCartoes\' + AArquivoDLL;
  If Not FileExists(LCaminhoDLL) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO','O arquivo ' + AArquivoDLL + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!',['&OK']);
    Exit;
  End;

  LEmpresa := Concat(VS_FuncoesExternas.fIRetEmpresaLogada, ' - ',
                     TLibCartoesFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada));

  LHandleLibCartoes := 0;
  Try
    LHandleLibCartoes := LoadLibrary(PChar(LCaminhoDLL));

    dxInitialize := GetProcAddress(LHandleLibCartoes, 'dxInitialize');
    dxInitialize;

    InicializaObjetoLibCartoes := GetProcAddress(LHandleLibCartoes, pChar('InicializaObjetoLibCartoes'));
    InicializaObjetoLibCartoes(TLibCartoesFactory.Get);

    SetStyleAutcom := GetProcAddress(LHandleLibCartoes, pChar('SetStyleAutcom'));
    SetStyleAutcom(VS_FuncoesExternas.fIExecutandoModoClassico);

    VerificaEstruturaTabelas := GetProcAddress(LHandleLibCartoes, pChar('VerificaEstruturaTabelas'));
    VerificaEstruturaTabelas;

    pAtualizaObjetoTelasAbertas := GetProcAddress(LHandleLibCartoes, pChar('pAtualizaObjetoTelasAbertas'));
    If VS_FuncoesExternas.fIGetObjetoTelasAbertas <> Nil Then
      pAtualizaObjetoTelasAbertas(VS_FuncoesExternas.fIGetObjetoTelasAbertas);

    ExcluirArquivosImportados := GetProcAddress(LHandleLibCartoes, pChar('ExcluirArquivosImportados'));
    ExcluirArquivosImportados(Application.Handle, ExtractFilePath(Application.ExeName), LEmpresa);
  Finally
    LiberaLibMemoria(LHandleLibCartoes);
  End;
end;

class procedure TMenuLibCartoes.ExportacaoLibCartoesDLL(AArquivoDLL: String;
  ALayoutAPI: Boolean);
 Var
    LHandleLibCartoes: THandle;

    LEmpresa,
    LCaminhoDLL: String;

    dxInitialize: procedure; StdCall;
    InicializaObjetoLibCartoes: procedure(AObjetoLibCartoes: ILibCartoes); StdCall;
    VerificaEstruturaTabelas: procedure; StdCall;
    pAtualizaObjetoTelasAbertas: procedure(ATelaAbertas: ITelasAbertas); StdCall;
    SetStyleAutcom: procedure(AAutcomModoClassico: Boolean); StdCall;

    ExportarArquivos: procedure(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
begin
  LCaminhoDLL := ExtractFilePath(Application.ExeName) + 'libCartoes\' + AArquivoDLL;
  If Not FileExists(LCaminhoDLL) Then
  Begin
    VS_FuncoesExternas.fIMensagem('ATENÇÃO','O arquivo ' + AArquivoDLL + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!',['&OK']);
    Exit;
  End;

  LEmpresa := Concat(VS_FuncoesExternas.fIRetEmpresaLogada, ' - ',
                     TLibCartoesFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada));

  LHandleLibCartoes := 0;
  Try
    LHandleLibCartoes := LoadLibrary(PChar(LCaminhoDLL));

    dxInitialize := GetProcAddress(LHandleLibCartoes, 'dxInitialize');
    dxInitialize;

    InicializaObjetoLibCartoes := GetProcAddress(LHandleLibCartoes, pChar('InicializaObjetoLibCartoes'));
    InicializaObjetoLibCartoes(TLibCartoesFactory.Get);

    SetStyleAutcom := GetProcAddress(LHandleLibCartoes, pChar('SetStyleAutcom'));
    SetStyleAutcom(VS_FuncoesExternas.fIExecutandoModoClassico);

    VerificaEstruturaTabelas := GetProcAddress(LHandleLibCartoes, pChar('VerificaEstruturaTabelas'));
    VerificaEstruturaTabelas;

    pAtualizaObjetoTelasAbertas := GetProcAddress(LHandleLibCartoes, pChar('pAtualizaObjetoTelasAbertas'));
    If VS_FuncoesExternas.fIGetObjetoTelasAbertas <> Nil Then
      pAtualizaObjetoTelasAbertas(VS_FuncoesExternas.fIGetObjetoTelasAbertas);

    ExportarArquivos := GetProcAddress(LHandleLibCartoes, pChar('ExportarArquivos'));
    ExportarArquivos(Application.Handle, ExtractFilePath(Application.ExeName), LEmpresa);
  Finally
    LiberaLibMemoria(LHandleLibCartoes);
  End;
end;

class procedure TMenuLibCartoes.ImportarLibCartoesDLL(AArquivoDLL: String;
  ALayoutAPI: Boolean);
  Var
    LHandleLibCartoes: THandle;

    LEmpresa,
    LCaminhoDLL: String;

    dxInitialize: procedure; StdCall;
    InicializaObjetoLibCartoes: procedure(AObjetoLibCartoes: ILibCartoes); StdCall;
    VerificaEstruturaTabelas: procedure; StdCall;
    pAtualizaObjetoTelasAbertas: procedure(ATelaAbertas: ITelasAbertas); StdCall;
    SetStyleAutcom: procedure(AAutcomModoClassico: Boolean); StdCall;

    ImportarCartoesArquivo: procedure(AAplicacao: HWND; APastaAutcom: String; ANomeEmpresa: String); StdCall;
    ImportarCartoesAPI: procedure(AAplicacao: HWND; ANomeEmpresa: String); StdCall;

    GetDadosFiltroImportacaoAPI: function: TDadosImportacaoConfirmacao; StdCall;
begin
  LCaminhoDLL := ExtractFilePath(Application.ExeName) + 'libCartoes\' + AArquivoDLL;
  If Not FileExists(LCaminhoDLL) Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO','O arquivo ' + AArquivoDLL + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!',['&OK']);
    Exit;
  End;

  LEmpresa := Concat(VS_FuncoesExternas.fIRetEmpresaLogada, ' - ',
                     TLibCartoesFuncoes.RetornaNomeEmpresa(VS_FuncoesExternas.fIRetEmpresaLogada));

  LHandleLibCartoes := 0;
  Try
    LHandleLibCartoes := SafeLoadLibrary(PChar(LCaminhoDLL));

    dxInitialize := GetProcAddress(LHandleLibCartoes, 'dxInitialize');
    dxInitialize;

    InicializaObjetoLibCartoes := GetProcAddress(LHandleLibCartoes, pChar('InicializaObjetoLibCartoes'));
    InicializaObjetoLibCartoes(TLibCartoesFactory.Get);

    SetStyleAutcom := GetProcAddress(LHandleLibCartoes, pChar('SetStyleAutcom'));
    SetStyleAutcom(VS_FuncoesExternas.fIExecutandoModoClassico);

    VerificaEstruturaTabelas := GetProcAddress(LHandleLibCartoes, pChar('VerificaEstruturaTabelas'));
    VerificaEstruturaTabelas;

    pAtualizaObjetoTelasAbertas := GetProcAddress(LHandleLibCartoes, pChar('pAtualizaObjetoTelasAbertas'));
    If VS_FuncoesExternas.fIGetObjetoTelasAbertas <> Nil Then
      pAtualizaObjetoTelasAbertas(VS_FuncoesExternas.fIGetObjetoTelasAbertas);

    If Not ALayoutAPI Then
    Begin
      ImportarCartoesArquivo := GetProcAddress(LHandleLibCartoes, pChar('ImportarCartoesArquivo'));
      ImportarCartoesArquivo(Application.Handle, ExtractFilePath(Application.ExeName), LEmpresa);
      Exit;
    End;

    ImportarCartoesAPI := GetProcAddress(LHandleLibCartoes, pChar('ImportarCartoesAPI'));
    ImportarCartoesAPI(Application.Handle, LEmpresa);

    TLibCartoesFuncoes.FDadosImportacaoConfirmacao := Nil;
    GetDadosFiltroImportacaoAPI := GetProcAddress(LHandleLibCartoes, pChar('GetDadosFiltroImportacaoAPI'));
    If Assigned(GetDadosFiltroImportacaoAPI) Then
      TLibCartoesFuncoes.FDadosImportacaoConfirmacao := GetDadosFiltroImportacaoAPI;
  Finally
    LiberaLibMemoria(LHandleLibCartoes);
  End;
end;

class procedure TMenuLibCartoes.LiberaLibMemoria(
  var AHandleLibCartoes: THandle);
begin
  Try
    If AHandleLibCartoes = 0 Then
      Exit;

    FreeLibrary(AHandleLibCartoes);
    AHandleLibCartoes := 0;
  Finally
    VS_FuncoesExternas.pITrimAppMemorySize;
  End;
end;

class procedure TMenuLibCartoes.OnClickAntecipacao(Sender: TObject);
  Var
    LLayout,
    LNomeDLL: String;
begin
  LLayout := TCustomMenuItemCartoes(Sender).Layout;

  LNomeDLL := TCustomMenuItemCartoes(Sender).LibAcesso;

  AnteciparLibCartoesDLL(LNomeDLL, LLayout.ToUpperInvariant.Equals('API'));

  Application.BringToFront;
end;

class procedure TMenuLibCartoes.OnClickBaixaRecebiveisMkt(Sender: TObject);
  Var
    LLayout,
    LNomeDLL: String;
begin
  LLayout := TCustomMenuItemCartoes(Sender).Layout;

  LNomeDLL := TCustomMenuItemCartoes(Sender).LibAcesso;

  BaixarRecebiveisMktLibCartoesDLL(LNomeDLL, LLayout.ToUpperInvariant.Equals('API'));

  Application.BringToFront;
end;

class procedure TMenuLibCartoes.OnClickConciliacao(Sender: TObject);
  Var
    LLayout,
    LNomeDLL: String;
begin
  LLayout := TCustomMenuItemCartoes(Sender).Layout;

  LNomeDLL := TCustomMenuItemCartoes(Sender).LibAcesso;

  ConciliarLibCartoesDLL(LNomeDLL, LLayout.ToUpperInvariant.Equals('API'));

  Application.BringToFront;
end;

class procedure TMenuLibCartoes.OnClickConfirmacaoCartoes;
  Var
    LConfirmacaoDeCartoes : TfrmLibCartoesConfirmacaoDeCartoes;
Begin
  TLibCartoesFuncoes.CarregaCorZebra;

  TLibCartoesFuncoes.pCriarFormularios(TfrmLibCartoesConfirmacaoDeCartoes, LConfirmacaoDeCartoes);
  Try
    Try
      LConfirmacaoDeCartoes.ShowModal;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.message, '[TMenuLibCartoes.OnClickConfirmacaoCartoes]');
      End;
    End;
  Finally
    FreeAndNil(LConfirmacaoDeCartoes);
  End;
end;

class procedure TMenuLibCartoes.OnClickExclusao(Sender: TObject);
  Var
    LLayout,
    LNomeDLL: String;
begin
  LLayout := TCustomMenuItemCartoes(Sender).Layout;

  LNomeDLL := TCustomMenuItemCartoes(Sender).LibAcesso;

  ExclusaoLibCartoesDLL(LNomeDLL, LLayout.ToUpperInvariant.Equals('API'));

  Application.BringToFront;
end;

class procedure TMenuLibCartoes.OnClickExportacao(Sender: TObject);
Var
    LLayout,
    LNomeDLL: String;
begin
  LLayout := TCustomMenuItemCartoes(Sender).Layout;

  LNomeDLL := TCustomMenuItemCartoes(Sender).LibAcesso;

  ExportacaoLibCartoesDLL(LNomeDLL, LLayout.ToUpperInvariant.Equals('API'));

  Application.BringToFront;

end;

class procedure TMenuLibCartoes.OnClickImportacao(Sender: TObject);
  Var
    LLayout,
    LNomeDLL: String;
begin
  LLayout := TCustomMenuItemCartoes(Sender).Layout;

  LNomeDLL := TCustomMenuItemCartoes(Sender).LibAcesso;

  ImportarLibCartoesDLL(LNomeDLL, LLayout.ToUpperInvariant.Equals('API'));

  Application.BringToFront;
end;

function TMenuLibCartoes.RetornaMenusAntecipacao: TCustomMenuItemCartoes;
Var
  LMenuAdicionar: TCustomMenuItemCartoes;

  LMenuItem: Integer;
begin
  Result := TCustomMenuItemCartoes.Create(Nil);
  Result.Name := 'mnuAntecipacaoCartoes';
  Result.OnClick := Nil;

  For LMenuItem := 0 To FMenuAntecipacaoCartoes.Count - 1 Do
  Begin
    LMenuAdicionar := TCustomMenuItemCartoes.Create(Result);
    LMenuAdicionar.Name := FMenuAntecipacaoCartoes[LMenuItem].Name;
    LMenuAdicionar.Caption := FMenuAntecipacaoCartoes[LMenuItem].Caption;
    LMenuAdicionar.Hint := FMenuAntecipacaoCartoes[LMenuItem].Hint;
    LMenuAdicionar.Visible := True;
    LMenuAdicionar.OnClick := TMenuLibCartoes.OnClickAntecipacao;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(FMenuAntecipacaoCartoes[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(FMenuAntecipacaoCartoes[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(FMenuAntecipacaoCartoes[LMenuItem]).Layout;

    Result.Add(LMenuAdicionar);
  End;
end;

function TMenuLibCartoes.RetornaMenusBaixaRecebiveisMkt: TCustomMenuItemCartoes;
  Var
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuItem: Integer;
begin
  Result := TCustomMenuItemCartoes.Create(Nil);
  Result.Name := 'mnuBaixaRecebiveisMkt';
  Result.OnClick := Nil;

  For LMenuItem := 0 To FMenuBaixaRecebiveisMkt.Count - 1 Do
  Begin
    LMenuAdicionar := TCustomMenuItemCartoes.Create(Result);
    LMenuAdicionar.Name := FMenuBaixaRecebiveisMkt[LMenuItem].Name;
    LMenuAdicionar.Caption := FMenuBaixaRecebiveisMkt[LMenuItem].Caption;
    LMenuAdicionar.Hint := FMenuBaixaRecebiveisMkt[LMenuItem].Hint;
    LMenuAdicionar.Visible := True;
    LMenuAdicionar.OnClick := TMenuLibCartoes.OnClickBaixaRecebiveisMkt;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(FMenuBaixaRecebiveisMkt[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(FMenuBaixaRecebiveisMkt[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(FMenuBaixaRecebiveisMkt[LMenuItem]).Layout;

    Result.Add(LMenuAdicionar);
  End;
end;

function TMenuLibCartoes.RetornaMenusConciliacao: TCustomMenuItemCartoes;
  Var
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuItem: Integer;
begin
  Result := TCustomMenuItemCartoes.Create(Nil);
  Result.Name := 'mnuConciliacaoCartoes';
  Result.OnClick := Nil;

  For LMenuItem := 0 To FMenuConciliacaoCartoes.Count - 1 Do
  Begin
    LMenuAdicionar := TCustomMenuItemCartoes.Create(Result);
    LMenuAdicionar.Name := FMenuConciliacaoCartoes[LMenuItem].Name;
    LMenuAdicionar.Caption := FMenuConciliacaoCartoes[LMenuItem].Caption;
    LMenuAdicionar.Hint := FMenuConciliacaoCartoes[LMenuItem].Hint;
    LMenuAdicionar.Visible := True;
    LMenuAdicionar.OnClick := TMenuLibCartoes.OnClickConciliacao;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(FMenuConciliacaoCartoes[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(FMenuConciliacaoCartoes[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(FMenuConciliacaoCartoes[LMenuItem]).Layout;

    Result.Add(LMenuAdicionar);
  End;
end;

function TMenuLibCartoes.RetornaMenusExclusaoArquivosImportados: TCustomMenuItemCartoes;
  Var
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuItem: Integer;
begin
  Result := TCustomMenuItemCartoes.Create(Nil);
  Result.Name := 'mnuExclusaoDeArquivosImportados';
  Result.OnClick := Nil;

  For LMenuItem := 0 To FMenuExclusaoArquivosImportados.Count - 1 Do
  Begin
    LMenuAdicionar := TCustomMenuItemCartoes.Create(Result);
    LMenuAdicionar.Name := FMenuExclusaoArquivosImportados[LMenuItem].Name;
    LMenuAdicionar.Caption := FMenuExclusaoArquivosImportados[LMenuItem].Caption;
    LMenuAdicionar.Hint := FMenuExclusaoArquivosImportados[LMenuItem].Hint;
    LMenuAdicionar.Visible := True;
    LMenuAdicionar.OnClick := TMenuLibCartoes.OnClickExclusao;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(FMenuExclusaoArquivosImportados[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(FMenuExclusaoArquivosImportados[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(FMenuExclusaoArquivosImportados[LMenuItem]).Layout;

    Result.Add(LMenuAdicionar);
  End;
end;

function TMenuLibCartoes.RetornaMenusExportacaoArquivos: TCustomMenuItemCartoes;
Var
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuItem: Integer;
begin
  Result := TCustomMenuItemCartoes.Create(Nil);
  Result.Name :='mnuExportacaoCartoes';// 'mnuExportacaoCartoes';
  Result.OnClick := Nil;

  For LMenuItem := 0 To FMenuExportacaoCartoes.Count - 1 Do
  Begin
    LMenuAdicionar := TCustomMenuItemCartoes.Create(Result);
    LMenuAdicionar.Name := FMenuExportacaoCartoes[LMenuItem].Name;
    LMenuAdicionar.Caption := FMenuExportacaoCartoes[LMenuItem].Caption;
    LMenuAdicionar.Hint := FMenuExportacaoCartoes[LMenuItem].Hint;
    LMenuAdicionar.Visible := True;
    LMenuAdicionar.OnClick := TMenuLibCartoes.OnClickExportacao;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(FMenuExportacaoCartoes[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(FMenuExportacaoCartoes[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(FMenuExportacaoCartoes[LMenuItem]).Layout;

    Result.Add(LMenuAdicionar);
  End;

end;

function TMenuLibCartoes.RetornaMenusImportacao: TCustomMenuItemCartoes;
  Var
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuItem: Integer;
begin
  Result := TCustomMenuItemCartoes.Create(Nil);
  Result.Name := 'mnuImportacaoCartoes';
  Result.OnClick := Nil;

  For LMenuItem := 0 To FMenuImportacaoCartoes.Count - 1 Do
  Begin
    LMenuAdicionar := TCustomMenuItemCartoes.Create(Result);
    LMenuAdicionar.Name := FMenuImportacaoCartoes[LMenuItem].Name;
    LMenuAdicionar.Caption := FMenuImportacaoCartoes[LMenuItem].Caption;
    LMenuAdicionar.Hint := FMenuImportacaoCartoes[LMenuItem].Hint;
    LMenuAdicionar.Visible := True;
    LMenuAdicionar.OnClick := TMenuLibCartoes.OnClickImportacao;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(FMenuImportacaoCartoes[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(FMenuImportacaoCartoes[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(FMenuImportacaoCartoes[LMenuItem]).Layout;

    Result.Add(LMenuAdicionar);
  End;
end;

function TMenuLibCartoes.RetornaMenusImportacaoRecebiveisMkt: TCustomMenuItemCartoes;
Var
  LMenuAdicionar: TCustomMenuItemCartoes;

  LMenuItem: Integer;
begin
  Result := TCustomMenuItemCartoes.Create(Nil);
  Result.Name := 'mnuImportacaoRecebiveisMkt';
  Result.OnClick := Nil;

  For LMenuItem := 0 To FMenuImportacaoRecebiveis.Count - 1 Do
  Begin
    LMenuAdicionar := TCustomMenuItemCartoes.Create(Result);
    LMenuAdicionar.Name := FMenuImportacaoRecebiveis[LMenuItem].Name;
    LMenuAdicionar.Caption := FMenuImportacaoRecebiveis[LMenuItem].Caption;
    LMenuAdicionar.Hint := FMenuImportacaoRecebiveis[LMenuItem].Hint;
    LMenuAdicionar.Visible := True;
    LMenuAdicionar.OnClick := TMenuLibCartoes.OnClickImportacao;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(FMenuImportacaoRecebiveis[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(FMenuImportacaoRecebiveis[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(FMenuImportacaoRecebiveis[LMenuItem]).Layout;

    Result.Add(LMenuAdicionar);
  End;
end;

end.
