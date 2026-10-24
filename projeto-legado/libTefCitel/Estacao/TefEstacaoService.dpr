program TefEstacaoService;

uses
  { ShareMem precisa ser a primeira unit - fCriarTefCitel (declarado em
    untTefEstacaoRoteadorMensagens.pas) agora e importado via "external
    'libTefCitel.dll' delayed" (decisao do Rafael, 2026-08-28: ver
    comentario completo no ponto de declaracao), e strings cruzam essa
    fronteira de DLL. Ate aqui este projeto compilava
    untTefCitelNCR/untScopeNCR/untTefCitel/untFuncoesLibTefCitel direto no
    fonte (native business logic + libs do Scope/CliSiTef linkadas
    estaticamente no proprio exe do servico) - essas 4 units (mais
    untTefCitelDvc/untTefCitelDvcTransporte, que so entravam por causa do
    import transitivo de untFuncoesLibTefCitel) nao fazem mais parte deste
    projeto. }
  ShareMem,
  Vcl.SvcMgr,
  untTefEstacaoServiceMain in 'untTefEstacaoServiceMain.pas',
  untTefEstacaoRoteadorMensagens in 'untTefEstacaoRoteadorMensagens.pas',
  untTefEstacaoTcpTransporte in 'untTefEstacaoTcpTransporte.pas',
  untTefEstacaoFilaLocal in 'untTefEstacaoFilaLocal.pas',
  untTefEstacaoLog in 'untTefEstacaoLog.pas',
  untTefEstacaoRegistroPlugin in 'untTefEstacaoRegistroPlugin.pas',
  untTefEstacaoAtualizacao in 'untTefEstacaoAtualizacao.pas',
  untTefEstacaoUpdateListener in 'untTefEstacaoUpdateListener.pas',
  untInterfaceTefCitel in '..\untInterfaceTefCitel.pas',
  untTefCitelComum in '..\untTefCitelComum.pas',
  untTefCitelAtuComum in '..\untTefCitelAtuComum.pas',
  untTefCitelIntervalos in '..\untTefCitelIntervalos.pas',
  untFormatarMensagemErro in '..\untFormatarMensagemErro.pas';

{$R *.RES}

begin
  { /registraplugin - registra o plug-in de canal no HKCU de quem chamou e
    sai. E o que a tarefa de logon do instalador executa (Req. 456190,
    2026-09-21).

    POR QUE AQUI DENTRO, e nao um .cmd com reg.exe

    A tarefa roda na sessao interativa do usuario. Acao de console - .cmd,
    reg.exe, qualquer um - faz o Windows criar uma janela de console, e o
    caixa via um lampejo a CADA logon. Este executavel e subsistema GUI
    (Vcl.SvcMgr), entao nao abre console nenhum.

    A alternativa seria wscript.exe + .vbs com janela oculta, descartada: um
    .vbs que escreve no registro a cada logon e a forma exata do que
    heuristica de antivirus procura, e este requisito ja tem o C.7 em aberto.
    Aqui nao ha binario novo - este exe ja esta na pasta e ja esta na
    exclusao do Defender.

    ANTES de Application.Initialize de proposito: nada de VCL, nada de SCM,
    nada de ShowMessage. Entra, grava, sai com codigo - que a tarefa registra
    em LastTaskResult, e e por ali que o suporte ve se funcionou. }
  if fPediuRegistrarPlugin then
    Halt(fRegistraPluginDoUsuario);

  Application.Initialize;
  Application.CreateForm(TTefEstacaoService, Servico);
  Application.Run;
end.
