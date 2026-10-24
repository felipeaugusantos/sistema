{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta suvinil *}
{**********************************************************************PH*}
unit untGravandoExecucaoSuvinilCores;

interface

uses
  untAbstractGravandoExecucaoSuvinil, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, Uni, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Forms,
  Vcl.Graphics, Windows;

type
  TGravandoExecucaoSuvinilCores = class(TAbstractGravandoExecucaoSuvinil)
  private
    function fUpdateMD5KEY: String;
    procedure RemoverFormulasSemColorante(const gravando: IGravando);
  public
    procedure CriarTmpSuvCadSuv;
    procedure pInserirMensagens;
    function GetSqlCriarFormulColorantesTmpSuvCadSuv(const intCont: Integer): string;
    function GetSqlCriarFormulQuantidadesTmpSuvCadSuv(const intCont: Integer): string;
    procedure GerarSuvCadSuv;
    procedure GerarMd5CadSuv(const gravando: IGravando);
    procedure pApagandoTemporarias;
    procedure pRemoveAcento();
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fHabilitaOpcao(): Boolean; Override;
  end;

  TQryCoresTmp = class(TAbstractCriadorTabela)
  Private
    function fRetornaTonalidade(intCodigo: Integer): String;
    function HexToTColor(sColor : string) : TColor;
    function CorParaRGB(AColor: TColor; strSigla: String): string;
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryProdutosTmp = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryGruposTmp = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryEmbalagensTmp = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryTonalidades = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryCoresColorantesTmp = class(TAbstractCriadorTabela)
  Private
    function fSqlInsert(intTabela: Integer): String;
    procedure PreencherColorantes();
  protected
    procedure ExecutarGeral(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); Override;
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); Override;
  end;

  TQryBasesTmp = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryProdutosBasesEmbalagensTmp = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryColorantesTmp = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryMensagensTmp = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

  TQryMensagensCoresBasesEmbalagensTmp = class(TAbstractCriadorTabela)
  protected
    procedure CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando); override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoSuvinilCores }

procedure TGravandoExecucaoSuvinilCores.GerarMd5CadSuv(const gravando: IGravando);
var
  qrySelect: IDataSet;
begin
  qrySelect := TAutcomTintaFactory.Get.fGetDataSet;
  qrySelect.SQL := fUpdateMD5KEY;
  qrySelect.ExecSQL;
end;

procedure TGravandoExecucaoSuvinilCores.GerarSuvCadSuv;
var
  qryInsert: IDataSet;
begin
  qryInsert := TAutcomTintaFactory.Get.fGetDataSet;
  qryInsert.SQL := 'SET @AUTO = 0;';
  qryInsert.ExecSQL;

  qryInsert.SQL :=
    'INSERT INTO SUV_CADSUV                     ' +
    'SELECT                                     ' +
    '  CONCAT(''001'', LPAD(@AUTO := IFNULL(@AUTO, 0) + 1, 14, ''0''), ''001'') AUTOINCREM ' +
    '  , SUV_CODITE                             ' +
    '  , SUV_CODEMP                             ' +
    '  , SUV_DESCRI                             ' +
    '  , SUV_REFERE                             ' +
    '  , SUV_UNIDAD                             ' +
    '  , SUV_PREVEN                             ' +
    '  , SUV_PRECUS                             ' +
    '  , SUV_FORM01                             ' +
    '  , SUV_QTDB01                             ' +
    '  , SUV_FORM02                             ' +
    '  , SUV_QTDB02                             ' +
    '  , SUV_FORM03                             ' +
    '  , SUV_QTDB03                             ' +
    '  , SUV_FORM04                             ' +
    '  , SUV_QTDB04                             ' +
    '  , SUV_FORM05                             ' +
    '  , SUV_QTDB05                             ' +
    '  , 0 SUV_COLVEN                           ' +
    '  , 0 SUV_COLCUS                           ' +
    '  , SUV_FORM06                             ' +
    '  , SUV_QTDB06                             ' +
    '  , SUV_FORM07                             ' +
    '  , SUV_QTDB07                             ' +
    '  , SUV_FORM08                             ' +
    '  , SUV_QTDB08                             ' +
    '  , SUV_FORM09                             ' +
    '  , SUV_QTDB09                             ' +
    '  , SUV_FORM10                             ' +
    '  , SUV_QTDB10                             ' +
    '  , SUV_FORM11                             ' +
    '  , SUV_QTDB11                             ' +
    '  , SUV_FORM12                             ' +
    '  , SUV_QTDB12                             ' +
    '  , SUV_FORM13                             ' +
    '  , SUV_QTDB13                             ' +
    '  , SUV_FORM14                             ' +
    '  , SUV_QTDB14                             ' +
    '  , SUV_FORM15                             ' +
    '  , SUV_QTDB15                             ' +
    '  , SUV_CODFML                             ' +
    '  , SUV_CODBAS                             ' +
    '  , SUV_CODUNI                             ' +
    '  , SUV_NOMCOR                             ' +
    '  , SUV_MD5KEY                             ' +
    '  , ''S''                                  ' +
    '  , SUV_FORM16                             ' +
    '  , SUV_FORM17                             ' +
    '  , SUV_FORM18                             ' +
    '  , SUV_FORM19                             ' +
    '  , SUV_FORM20                             ' +
    '  , SUV_QTDB16                             ' +
    '  , SUV_QTDB17                             ' +
    '  , SUV_QTDB18                             ' +
    '  , SUV_QTDB19                             ' +
    '  , SUV_QTDB20                             ' +
    '  , NULL                                   ' +
    '  , SUV_ACRMOB                             ' +
    '  , SUV_R_G_B_                             ' +
    '  , SUV_TONALI                             ' +
    '  , SUV_CORNOM                             ' +
    '  , SUV_RED___                             ' +
    '  , SUV_GREEN_                             ' +
    '  , SUV_BLUE__                             ' +
    'FROM                                       ' +
    '  TMP_SUV_CADSUV                           ' ;

  qryInsert.ExecSQL;
end;

function TGravandoExecucaoSuvinilCores.GetSqlCriarFormulColorantesTmpSuvCadSuv(const intCont: Integer): string;
begin
  Result :=
    ' UPDATE                                         ' +
    '   TMP_SUV_CADSUV S                             ' +
    ' SET                                            ' +
    '   S.SUV_FORM' + TStrUtils.fStrZero(intCont, 2) + ' =                               ' +
    '   (SELECT                                      ' +
    '     CX.SIGLA_COLORANTE                         ' +
    '   FROM                                         ' +
    '     TMP_QRYCORESCOLORANTES CX                  ' +
    '   WHERE CX.QTDE > 0                            ' +
    '     AND CX.COD_BASE = S.COD_BASE               ' +
    '     AND CX.COD_COR = S.COD_COR                 ' +
    '     AND CX.COD_EMBALAGEM = S.COD_EMBALAGEM     ' +
    '     AND CX.COD_GRUPO = S.COD_GRUPO             ' +
    '     AND CX.COD_PRODUTO = S.COD_PRODUTO         ' +
    '   ORDER BY CX.COD_COLORANTE                    ' +
    '   LIMIT ' + IntToStr(intCont - 1) + ', 1)      ';
end;

function TGravandoExecucaoSuvinilCores.GetSqlCriarFormulQuantidadesTmpSuvCadSuv(const intCont: Integer): string;
begin
  Result :=
    ' UPDATE                                         ' +
    '   TMP_SUV_CADSUV S                             ' +
    ' SET                                            ' +
    '   S.SUV_QTDB' + TStrUtils.fStrZero(intCont, 2) + ' =                             ' +
    '   (SELECT                                      ' +
    '     CX.QTDE                                    ' +
    '   FROM                                         ' +
    '     TMP_QRYCORESCOLORANTES CX                  ' +
    '   WHERE CX.QTDE > 0                            ' +
    '     AND CX.COD_BASE = S.COD_BASE               ' +
    '     AND CX.COD_COR = S.COD_COR                 ' +
    '     AND CX.COD_EMBALAGEM = S.COD_EMBALAGEM     ' +
    '     AND CX.COD_GRUPO = S.COD_GRUPO             ' +
    '     AND CX.COD_PRODUTO = S.COD_PRODUTO         ' +
    '   ORDER BY CX.COD_COLORANTE                    ' +
    '   LIMIT ' + IntToStr(intCont - 1) + ', 1) * VOLUME_DEST / VOLUME_ORI       ';
end;

procedure TGravandoExecucaoSuvinilCores.pApagandoTemporarias;
begin
  TAutcomTintaFactory.Get.DropTable('TMP_QRYBASES');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYCOLORANTES');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYCORES');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYCORESCOLORANTES');
  TAutcomTintaFactory.Get.DropTable('TMP_TONALIDADES');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYEMBALAGENS');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYGRUPOS');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYPRODUTOS');
  TAutcomTintaFactory.Get.DropTable('TMP_QRYPRODUTOSBASESEMBALAGENS');
  TAutcomTintaFactory.Get.DropTable('TMP_SUV_CADSUV');
end;

procedure TGravandoExecucaoSuvinilCores.pInserirMensagens;
var
  qryMensagem : IDataSet;
begin

  qryMensagem := TAutcomTintaFactory.Get.fGetDataSet;
  qryMensagem.SQL :=  ' INSERT INTO SUV_CADMSG(   ' +
                      '     MSG_DESCRI            ' +
                      '   , MSG_REFERE            ' +
                      '   , MSG_UNIDAD            ' +
                      '   , MSG_CODFML            ' +
                      '   , MSG_NOMCOR            ' +
                      '   , MSG_CODBAS            ' +
                      '   , MSG_MENSAG            ' +
                      ' )                         ' +
                      '  SELECT DISTINCT          ' +
                      '       UPPER(DES_PRODUTO) SUV_DESCRI                                                 ' +
                      '     , UPPER(CONCAT(DES_GRUPO, '' '', C.DES_COR)) SUV_REFERE                         ' +
                      '     , IF(ED.VOLUME <= 0.9, ''LT'', IF(ED.VOLUME = 4.4, ''BD'',  IF(ED.VOLUME <= 5.8, ''GL'', ' +
                      '       IF(ED.VOLUME <= 19, ''LA'', IF(ED.VOLUME = 21, ''1J'',  IF(ED.VOLUME = 22, ''2J'', ' +
                      '       IF(ED.VOLUME = 24, ''3J'', IF(ED.VOLUME = 25, ''4J'', IF(ED.VOLUME = 26, ''5J'', ' +
                      '       IF(ED.VOLUME = 29, ''6J'', ''LA'')))))))))) SUV_UNIDAD                      ' +
                      '     , C.COD_PRODUTO SUV_CODFML                                                      ' +
                      '     , CONCAT(C.NOM_COR, '' - '', C.COD_COR) SUV_NOMCOR                              ' +
                      '     , DES_BASE                                                                    ' +
                      '     , MSG.MENSAGEM                                                                  ' +
                      '  FROM TMP_QRYCORES C                                                                ' +
                      ' INNER JOIN TMP_QRYPRODUTOS P                          ON C.COD_PRODUTO      = P.COD_PRODUTO     ' +
                      ' INNER JOIN TMP_QRYGRUPOS G                            ON C.COD_GRUPO        = G.COD_GRUPO       ' +
                      ' INNER JOIN TMP_QRYEMBALAGENS E                        ON C.COD_EMBALAGEM    = E.COD_EMBALAGEM   ' +
                      ' INNER JOIN TMP_QRYBASES B                             ON C.COD_BASE         = B.COD_BASE        ' +
                      ' INNER JOIN TMP_QRYPRODUTOSBASESEMBALAGENS PBE         ON C.COD_PRODUTO      = PBE.COD_PRODUTO   ' +
                      '                                                      AND C.COD_BASE         = PBE.COD_BASE      ' +
                      ' INNER JOIN TMP_QRYEMBALAGENS ED                       ON PBE.COD_EMBALAGEM  = ED.COD_EMBALAGEM  ' +
                      ' INNER JOIN TMP_QRYMENSAGENSCORESBASESEMBALAGENS MCBE  ON MCBE.COD_COR       = C.COD_COR         ' +
                      ' INNER JOIN TMP_QRYMENSAGENS MSG                       ON MSG.COD_MENSAGEM   = MCBE.COD_MENSAGEM ' ;
  qryMensagem.ExecSQL;
end;

procedure TGravandoExecucaoSuvinilCores.pRemoveAcento;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '  UPDATE           ' +
                '   SUV_CADSUV      ' +
                '  SET              ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Á'', ''A''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Â'', ''A''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Ã'', ''A''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Ç'', ''C''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''É'', ''E''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Ê'', ''E''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Í'', ''I''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Ñ'', ''N''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Ó'', ''O''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Ô'', ''O''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Õ'', ''O''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Ú'', ''U''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''Ü'', ''U''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''á'', ''a''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''â'', ''a''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''ã'', ''a''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''ç'', ''c''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''é'', ''e''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''ê'', ''e''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''í'', ''i''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''ñ'', ''n''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''ó'', ''o''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''ô'', ''o''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''õ'', ''o''), ' +
                '   SUV_NOMCOR = REPLACE(SUV_NOMCOR, ''ú'', ''u''); ';

  qryGen.SQL := qryGen.SQL + '  UPDATE           ' +
                         '   SUV_CADSUV      ' +
                         '  SET              ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Á'', ''A''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Â'', ''A''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ã'', ''A''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ç'', ''C''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''É'', ''E''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ê'', ''E''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Í'', ''I''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ñ'', ''N''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ó'', ''O''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ô'', ''O''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Õ'', ''O''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ú'', ''U''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''Ü'', ''U''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''á'', ''a''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''â'', ''a''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ã'', ''a''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ç'', ''c''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''é'', ''e''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ê'', ''e''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''í'', ''i''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ñ'', ''n''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ó'', ''o''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ô'', ''o''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''õ'', ''o''), ' +
                         '   SUV_DESCRI = REPLACE(SUV_DESCRI, ''ú'', ''u''); ';

  qryGen.SQL := qryGen.SQL + '  UPDATE           ' +
                         '   SUV_CADMSG      ' +
                         '  SET              ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Á'', ''A''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Â'', ''A''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Ã'', ''A''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Ç'', ''C''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''É'', ''E''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Ê'', ''E''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Í'', ''I''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Ñ'', ''N''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Ó'', ''O''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Ô'', ''O''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Õ'', ''O''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Ú'', ''U''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''Ü'', ''U''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''á'', ''a''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''â'', ''a''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''ã'', ''a''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''ç'', ''c''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''é'', ''e''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''ê'', ''e''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''í'', ''i''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''ñ'', ''n''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''ó'', ''o''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''ô'', ''o''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''õ'', ''o''), ' +
                         '   MSG_DESCRI = REPLACE(MSG_DESCRI, ''ú'', ''u''); ';

  qryGen.SQL := qryGen.SQL + '  UPDATE           ' +
                         '   SUV_CADMSG      ' +
                         '  SET              ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Á'', ''A''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Â'', ''A''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Ã'', ''A''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Ç'', ''C''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''É'', ''E''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Ê'', ''E''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Í'', ''I''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Ñ'', ''N''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Ó'', ''O''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Ô'', ''O''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Õ'', ''O''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Ú'', ''U''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''Ü'', ''U''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''á'', ''a''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''â'', ''a''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''ã'', ''a''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''ç'', ''c''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''é'', ''e''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''ê'', ''e''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''í'', ''i''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''ñ'', ''n''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''ó'', ''o''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''ô'', ''o''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''õ'', ''o''), ' +
                         '   MSG_NOMCOR = REPLACE(MSG_NOMCOR, ''ú'', ''u''); ';

  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoSuvinilCores.RemoverFormulasSemColorante(const gravando: IGravando);
Var
  qryCores,
  qryMsg: IDataSet;
  qryDelete: IDataSet;
begin
  qryCores  := TAutcomTintaFactory.Get.fGetDataSet;
  qryMsg    := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelete := TAutcomTintaFactory.Get.fGetDataSet;

  qryCores.SQL := ' SELECT * FROM SUV_CADSUV WHERE SUV_FORM01 IS NULL ';
  qryMsg.SQL := ' SELECT * FROM SUV_CADMSG WHERE MSG_NOMCOR = :NOMCOR ';
  qryCores.Open;

  While Not qryCores.Eof Do
  Begin
    qryMsg.Close;
    qryMsg.ParamByName('NOMCOR').AsString := qryCores.FieldByName('SUV_NOMCOR').AsString;
    qryMsg.Open;

    If qryMsg.IsEmpty Then
    Begin
      qryDelete.SQL := '  DELETE FROM SUV_CADSUV WHERE SUV_NOMCOR = :DELETE ';
      qryDelete.ParamByName('DELETE').AsString := qryCores.FieldByName('SUV_NOMCOR').AsString;
      qryDelete.ExecSQL;
    End;

    qryCores.Next;
    Gravando.RegistrarProgresso(0, qryCores.RecNo, qryCores.RecordCount);
  End;
end;

procedure TGravandoExecucaoSuvinilCores.CriarTmpSuvCadSuv;
var
  qryInsert   : IDataSet;
begin
  qryInsert := TAutcomTintaFactory.Get.fGetDataSet;

  qryInsert := TAutcomTintaFactory.Get.fGetDataSet;
  qryInsert.SQL := 'SET @AUTO = 0;';
  qryInsert.ExecSQL;

  qryInsert.SQL :=
    ' INSERT INTO TMP_SUV_CADSUV (                                                                         ' +
    '   AUTOINCREM                                                                                         ' +
    '   , SUV_CODITE                                                                                       ' +
    '   , SUV_CODEMP                                                                                       ' +
    '   , SUV_DESCRI                                                                                       ' +
    '   , SUV_REFERE                                                                                       ' +
    '   , SUV_UNIDAD                                                                                       ' +
    '   , SUV_PREVEN                                                                                       ' +
    '   , SUV_PRECUS                                                                                       ' +
    '   , SUV_CODFML                                                                                       ' +
    '   , SUV_CODBAS                                                                                       ' +
    '   , SUV_CODUNI                                                                                       ' +
    '   , SUV_NOMCOR                                                                                       ' +
    '   , VOLUME_ORI                                                                                       ' +
    '   , VOLUME_DEST                                                                                      ' +
    '   , COD_BASE                                                                                         ' +
    '   , COD_COR                                                                                          ' +
    '   , COD_EMBALAGEM                                                                                    ' +
    '   , COD_GRUPO                                                                                        ' +
    '   , COD_PRODUTO                                                                                      ' +
    '   , SUV_TONALI                                                                                       ' +
    '   , SUV_R_G_B_                                                                                       ' +
    '   , SUV_CORNOM                                                                                       ' +
    '   , SUV_RED___                                                                                       ' +
    '   , SUV_GREEN_                                                                                       ' +
    '   , SUV_BLUE__                                                                                       ' +
    ' )                                                                                                    ' +
    ' SELECT DISTINCT                                                                                      ' +
    '   CONCAT(''001'', LPAD(@AUTO := IFNULL(@AUTO, 0) + 1, 14, ''0''), ''001'') AUTOINCREM                ' +
    '   , '''' SUV_CODITE                                                                                  ' +
    '   , ''001'' SUV_CODEMP                                                                               ' +
    '   , UPPER(DES_PRODUTO) SUV_DESCRI                                                                    ' +
    '   , UPPER(CONCAT(DES_GRUPO, '' '', C.DES_COR)) SUV_REFERE                                            ' +
    '   ,   IF(ED.VOLUME <= 0.9, ''LT'', IF(ED.VOLUME = 4.4, ''BD'',  IF(ED.VOLUME <= 5.8, ''GL'',         ' +
    '       IF(ED.VOLUME <= 19, ''LA'', IF(ED.VOLUME = 21, ''LA21'',  IF(ED.VOLUME = 22, ''LA22'',         ' +
    '       IF(ED.VOLUME = 24, ''LA24'', IF(ED.VOLUME = 25, ''LA25'', IF(ED.VOLUME = 26, ''LA26'',         ' +
    '       IF(ED.VOLUME = 29, ''LA29'', ''LA'')))))))))) SUV_UNIDAD                                       ' +
    '   , 0 SUV_PREVEN                                                                                     ' +
    '   , 0 SUV_PRECUS                                                                                     ' +
    '   , C.COD_PRODUTO SUV_CODFML                                                                         ' +
    '   , DES_BASE SUV_CODBAS                                                                              ' +
    '   ,   IF(ED.VOLUME <= 0.9, ''LT'', IF(ED.VOLUME = 4.4, ''BD'',  IF(ED.VOLUME <= 5.8, ''GL'',         ' +
    '       IF(ED.VOLUME <= 19, ''LA'', IF(ED.VOLUME = 21, ''1J'',  IF(ED.VOLUME = 22, ''2J'',             ' +
    '       IF(ED.VOLUME = 24, ''3J'', IF(ED.VOLUME = 25, ''4J'', IF(ED.VOLUME = 26, ''5J'',               ' +
    '       IF(ED.VOLUME = 29, ''6J'', ''LA'')))))))))) SUV_CODUNI                                         ' +
    '   , CONCAT(C.NOM_COR, '' - '', C.COD_COR) SUV_NOMCOR                                                 ' +
    '   , E.VOLUME VOLUME_ORI                                                                              ' +
    '   , ED.VOLUME VOLUME_DEST                                                                            ' +
    '   , C.COD_BASE                                                                                       ' +
    '   , C.COD_COR                                                                                        ' +
    '   , E.COD_EMBALAGEM                                                                                  ' +
    '   , C.COD_GRUPO                                                                                      ' +
    '   , C.COD_PRODUTO                                                                                    ' +
    '   , C.COD_TONALIDADE                                                                                 ' +
    '   , C.RGB                                                                                            ' +
    '   , C.NOM_COR SUV_CORNOM                                                                             ' +
    '   , C.RED                                                                                            ' +
    '   , C.GREEN                                                                                          ' +
    '   , C.BLUE                                                                                           ' +
    ' FROM                                                                                                 ' +
    '   TMP_QRYCORES C                                                                                     ' +
    '   INNER JOIN TMP_QRYPRODUTOS P                                                                       ' +
    '     ON C.COD_PRODUTO = P.COD_PRODUTO                                                                 ' +
    '   INNER JOIN TMP_QRYGRUPOS G                                                                         ' +
    '     ON C.COD_GRUPO = G.COD_GRUPO                                                                     ' +
    '   INNER JOIN TMP_QRYEMBALAGENS E                                                                     ' +
    '     ON C.COD_EMBALAGEM = E.COD_EMBALAGEM                                                             ' +
    '   INNER JOIN TMP_QRYBASES B                                                                          ' +
    '     ON C.COD_BASE = B.COD_BASE                                                                       ' +
    '   INNER JOIN TMP_QRYPRODUTOSBASESEMBALAGENS PBE                                                      ' +
    '     ON C.COD_PRODUTO = PBE.COD_PRODUTO                                                               ' +
    '     AND C.COD_BASE = PBE.COD_BASE                                                                    ' +
    '   INNER JOIN TMP_QRYEMBALAGENS ED                                                                    ' +
    '     ON PBE.COD_EMBALAGEM = ED.COD_EMBALAGEM                                                          ' ;
  qryInsert.ExecSQL;

//  pInserirMensagens;
end;

procedure TGravandoExecucaoSuvinilCores.Executar(const gravando: IGravando);
const
  QTD_COLS: Integer = 10;
var
  qryFormul: IDataSet;
  intCont: Integer;
begin
  Try
    Try

      CriarObjetos;

      gravando.Texto := 'Carregando dados...';
      CarregarDadosCores;
      gravando.Texto := 'Dados carregados com sucesso!';

      pApagandoTemporarias;

      if gravando.Status <> sgGravando then
      begin
        pApagandoTemporarias;
        Exit;
      end;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SUV_CADSUV');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
      begin
        pApagandoTemporarias;
        Exit;
      end;

      gravando.Texto := 'Limpando SUV_CADSUV...';
      TAutcomTintaFactory.Get.TruncateTable('SUV_CADSUV');
      gravando.Texto := 'SUV_CADSUV limpa com sucesso!';

      if gravando.Status <> sgGravando then
      begin
        pApagandoTemporarias;
        Exit;
      end;

      TCriadorTabelas.CriarTabelas([
        TQryProdutosTmp.Create('TMP_QRYPRODUTOS', qryProdutosCores,
          ' COD_PRODUTO SMALLINT (5) UNSIGNED NOT NULL DEFAULT ''0'' ' +
          ' , DES_PRODUTO VARCHAR (39) NOT NULL DEFAULT ''''         ' +
          ' , PRIMARY KEY (COD_PRODUTO)                              '),
        TQryGruposTmp.Create('TMP_QRYGRUPOS', qryGruposCores,
          ' COD_GRUPO CHAR(2) NOT NULL DEFAULT ''''        ' +
          ' , DES_GRUPO VARCHAR (21) NOT NULL DEFAULT '''' ' +
          ' , PRIMARY KEY (COD_GRUPO)                      '),
        TQryEmbalagensTmp.Create('TMP_QRYEMBALAGENS', qryEmbalagensCores,
          ' COD_EMBALAGEM CHAR(2) NOT NULL DEFAULT ''''     ' +
          ' , VOLUME DECIMAL (12, 4) NOT NULL DEFAULT ''0'' ' +
          ' , PRIMARY KEY (COD_EMBALAGEM)                   '),
        TQryBasesTmp.Create('TMP_QRYBASES', qryBasesCores,
          ' COD_BASE CHAR(2) NOT NULL DEFAULT ''''       ' +
          ' , DES_BASE VARCHAR (10) NOT NULL DEFAULT '''' ' +
          ' , PRIMARY KEY (COD_BASE)                     '),
        TQryProdutosBasesEmbalagensTmp.Create('TMP_QRYPRODUTOSBASESEMBALAGENS', qryProdutosBasesEmbalagensCores,
          ' COD_PRODUTO SMALLINT (5) UNSIGNED NOT NULL DEFAULT ''0'' ' +
          ' , COD_BASE CHAR(2) NOT NULL DEFAULT ''''                 ' +
          ' , COD_EMBALAGEM CHAR(2) NOT NULL DEFAULT ''''            ' +
          ' , PRIMARY KEY (COD_PRODUTO, COD_BASE, COD_EMBALAGEM)     '),
        TQryColorantesTmp.Create('TMP_QRYCOLORANTES', qryColorantesCores,
          ' COD_COLORANTE CHAR(2) NOT NULL DEFAULT ''''          ' +
          ' , SIGLA_COLORANTE CHAR(2) NOT NULL DEFAULT ''''      ' +
          ' , DES_COLORANTE VARCHAR (15) NOT NULL DEFAULT ''''   ' +
          ' , PRIMARY KEY (COD_COLORANTE)                        '),
        TQryTonalidades.Create('TMP_TONALIDADES', qryTonalidadesCores,
          ' COD_TONALIDADE SMALLINT (5) UNSIGNED NOT NULL DEFAULT ''0'' ' +
          ' , DES_TONALIDADE VARCHAR(50) NOT NULL DEFAULT '''' ' +
          ' , PRIMARY KEY (COD_TONALIDADE)                  '),
        TAbstractCriadorTabela.Create('TMP_SUV_CADSUV',
          '   AUTOINCREM VARCHAR (20)                                                                  ' +
          '   , SUV_CODITE CHAR('+IntToStr(TAutcomTintaFactory.Get.fTamCodIte)+')                      ' +
          '   , SUV_CODEMP VARCHAR (3)                                                                 ' +
          '   , SUV_DESCRI VARCHAR (40)                                                                ' +
          '   , SUV_REFERE VARCHAR (75)                                                                ' +
          '   , SUV_UNIDAD VARCHAR (4)                                                                 ' +
          '   , SUV_PREVEN DECIMAL (12, 4)                                                             ' +
          '   , SUV_PRECUS DECIMAL (12, 4)                                                             ' +
          '   , SUV_CODFML SMALLINT (5) UNSIGNED                                                       ' +
          '   , SUV_CODBAS VARCHAR (10)                                                                ' +
          '   , SUV_CODUNI VARCHAR (4)                                                                 ' +
          '   , SUV_NOMCOR VARCHAR (115)                                                               ' +
          '   , VOLUME_ORI DECIMAL (12, 4)                                                             ' +
          '   , VOLUME_DEST DECIMAL (12, 4)                                                            ' +
          '   , COD_BASE CHAR(2)                                                                       ' +
          '   , COD_COR VARCHAR (10)                                                                   ' +
          '   , COD_EMBALAGEM CHAR(2)                                                                  ' +
          '   , COD_GRUPO CHAR(2)                                                                      ' +
          '   , COD_PRODUTO SMALLINT (5) UNSIGNED                                                      ' +
          '   , SUV_FORM01 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB01 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM02 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB02 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM03 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB03 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM04 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB04 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM05 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB05 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM06 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB06 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM07 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB07 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM08 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB08 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM09 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB09 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM10 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB10 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM11 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB11 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM12 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB12 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM13 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB13 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM14 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB14 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM15 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB15 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM16 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB16 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM17 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB17 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM18 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB18 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM19 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB19 DOUBLE (12, 4)                                                              ' +
          '   , SUV_FORM20 VARCHAR (6)                                                                 ' +
          '   , SUV_QTDB20 DOUBLE (12, 4)                                                              ' +
          '   , SUV_MD5KEY VARCHAR(32)                                                                 ' +
          '   , SUV_ACRMOB DECIMAL(12, 4)                                                              ' +
          '   , SUV_R_G_B_ VARCHAR(6)                                                                  ' +
          '   , SUV_TONALI VARCHAR(50)                                                                 ' +
          '   , SUV_CORNOM VARCHAR(50)                                                                 ' +
          '   , SUV_RED___ CHAR(3)                                                                     ' +
          '   , SUV_GREEN_ CHAR(3)                                                                     ' +
          '   , SUV_BLUE__ CHAR(3)                                                                     ' +
          '   , KEY IDX_COD_COR (AUTOINCREM, COD_COR, COD_PRODUTO, COD_GRUPO, COD_EMBALAGEM, COD_BASE) '),

        TQryCoresColorantesTmp.Create('TMP_QRYCORESCOLORANTES', qryCoresColorantesCores,
          ' COD_BASE CHAR(2) NOT NULL DEFAULT ''''                                                  ' +
          ' , COD_COLORANTE CHAR(2) NOT NULL DEFAULT ''''                                           ' +
          ' , COD_COR VARCHAR (10) NOT NULL DEFAULT ''''                                            ' +
          ' , COD_EMBALAGEM CHAR(2) NOT NULL DEFAULT ''''                                           ' +
          ' , COD_GRUPO CHAR(2) NOT NULL DEFAULT ''''                                               ' +
          ' , COD_PRODUTO SMALLINT (5) UNSIGNED NOT NULL DEFAULT ''0''                              ' +
          ' , QTDE VARCHAR (54) NOT NULL DEFAULT ''''                                               ' +
          ' , SEQ_ATUALIZACAO INTEGER NOT NULL DEFAULT ''0''                                        ' +
          ' , SIGLA_COLORANTE CHAR(2) NULL                                                          ' +
          ' , PRIMARY KEY (COD_BASE, COD_COR, COD_EMBALAGEM, COD_GRUPO, COD_PRODUTO, COD_COLORANTE) ' +
          ' , KEY IDX_COR_COL(COD_COLORANTE)'),

        TQryCoresTmp.Create('TMP_QRYCORES', qryCoresCores,
          ' COD_BASE CHAR(2) DEFAULT NULL                    ' +
          ' , COD_COR VARCHAR (10) NOT NULL DEFAULT ''''     ' +
          ' , COD_EMBALAGEM CHAR(2) DEFAULT NULL             ' +
          ' , COD_GRUPO CHAR(2) DEFAULT NULL                 ' +
          ' , COD_PRODUTO SMALLINT (5) UNSIGNED DEFAULT NULL ' +
          ' , DES_COR VARCHAR (100) DEFAULT NULL             ' +
          ' , NOM_COR VARCHAR (50) DEFAULT NULL              ' +
          ' , COD_TONALIDADE VARCHAR(50) DEFAULT NULL        ' +
          ' , RGB VARCHAR(6) DEFAULT NULL                    ' +
          ' , RED CHAR(3) DEFAULT NULL                       ' +
          ' , GREEN CHAR(3) DEFAULT NULL                     ' +
          ' , BLUE CHAR(3) DEFAULT NULL                      ' +
          ' , PRIMARY KEY (COD_COR)                          '),

        TQryMensagensTmp.Create('TMP_QRYMENSAGENS', qryMensagensCores,
          ' COD_MENSAGEM VARCHAR(10) NOT NULL                ' +
          ' , MENSAGEM TEXT NOT NULL DEFAULT ''''            ' +
          ' , PRIMARY KEY (COD_MENSAGEM)                     '),

        TQryMensagensCoresBasesEmbalagensTmp.Create('TMP_QRYMENSAGENSCORESBASESEMBALAGENS', qryMensagensCoresBasesEmbalagensCores,
          ' COD_MENSAGEM VARCHAR(10) NOT NULL              ' +
          ' , COD_COR VARCHAR(10) NOT NULL DEFAULT ''''    ' +
          ' , KEY IDX_COD_MENSAGEM (COD_MENSAGEM)          ' +
          ' , KEY IDX_COD_COR (COD_COR)                    ')

      ], gravando);

      if gravando.Status <> sgGravando then
      begin
        pApagandoTemporarias;
        Exit;
      end;

      gravando.Texto := 'Preenchendo tabela TMP_SUV_CADSUV...';
      CriarTmpSuvCadSuv;
      gravando.Texto := 'Tabela TMP_SUV_CADSUV preenchida com sucesso!';

      gravando.Texto := 'Preenchendo tabela MENSAGENS...';
      pInserirMensagens;
      gravando.Texto := 'tabela MENSAGENS preenchida com sucesso!';

      if gravando.Status <> sgGravando then
      begin
        pApagandoTemporarias;
        Exit;
      end;

      qryFormul := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Gerando formulação colorantes...';
      for intCont := 1 to QTD_COLS do
      begin
        qryFormul.SQL := GetSqlCriarFormulColorantesTmpSuvCadSuv(intCont);
        qryFormul.ExecSQL;
        gravando.Texto := Format('Formulação colorante %d gerada com sucesso!', [intCont]);
        gravando.RegistrarProgresso(0, intCont, QTD_COLS);

        if gravando.Status <> sgGravando then
        begin
          pApagandoTemporarias;
          Exit;
        end;
      end;

      gravando.Texto := 'Gerando formulação quantidade...';
      for intCont := 1 to QTD_COLS do
      begin
        qryFormul.SQL := GetSqlCriarFormulQuantidadesTmpSuvCadSuv(intCont);
        qryFormul.ExecSQL;
        gravando.Texto := Format('Formulação quantidade %d gerada com sucesso!', [intCont]);
        gravando.RegistrarProgresso(0, intCont, QTD_COLS);

        if gravando.Status <> sgGravando then
        begin
          pApagandoTemporarias;
          Exit;
        end;
      end;

      gravando.Texto := 'Calculando SUV_MD5KEY...';
      GerarMd5CadSuv(gravando);
      gravando.Texto := 'SUV_MD5KEY Calculado com sucesso!';

      gravando.Texto := 'Gerando SUV_CADSUV...';
      GerarSuvCadSuv;
      gravando.Texto := 'SUV_CADSUV gerado com sucesso!';

      Gravando.Texto := 'Removendo acentos...';
      pRemoveAcento;

      Gravando.Texto := 'Removendo fórmulas sem colorantes e quantidades...';
      RemoverFormulasSemColorante(Gravando);

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    pApagandoTemporarias;
    DestruirObjetos;
  End;
end;

function TGravandoExecucaoSuvinilCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoSuvinilCores.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoSuvinilCores.fUpdateMD5KEY: String;
begin
  Result := '';
  Result := Result + ' UPDATE TMP_SUV_CADSUV ';
  Result := Result + '    SET SUV_MD5KEY = UPPER(CAST(MD5(CONCAT(  ';
  Result := Result + '		       IFNULL(SUV_CODFML, "") ';
  Result := Result + '		     , IFNULL(SUV_CODBAS, "") ';
  Result := Result + '		     , IFNULL(SUV_CODUNI, "") ';
  Result := Result + '		     , IFNULL(SUV_NOMCOR, "") ';
  Result := Result + '		     , IFNULL(SUV_DESCRI, "") ';
  Result := Result + '		     , IFNULL(SUV_REFERE, "") ';
  Result := Result + '		     , IFNULL(SUV_UNIDAD, "") ';

  Result := Result + '		     , IFNULL(SUV_FORM01, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB01, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM02, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB02, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM03, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB03, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM04, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB04, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM05, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB05, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM06, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB06, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM07, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB07, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM08, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB08, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM09, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB09, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM10, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB10, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM11, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB11, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM12, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB12, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM13, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB13, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM14, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB14, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM15, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB15, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM16, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB16, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM17, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB17, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM18, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB18, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM19, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB19, 0.0000), 4), '','',''.'') ';

  Result := Result + '		     , IFNULL(SUV_FORM20, "") ';
  Result := Result + '		     , REPLACE(FORMAT(IFNULL(SUV_QTDB20, 0.0000), 4), '','',''.''))) AS CHAR)) ';
end;

{ TQryCoresTmp }

procedure TQryCoresTmp.CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando);
Var
  AColor: TColor;
begin
  if (Pos(qryOrigem.FieldByName('SITUACAO').AsString, 'A_a_')  <= 0) then
    Exit;

  qryGrava.ParamByName('COD_BASE').AsString := qryOrigem.FieldByName('COD_BASE').AsString;
  qryGrava.ParamByName('COD_COR').AsString := qryOrigem.FieldByName('COD_COR').AsString;
  qryGrava.ParamByName('COD_EMBALAGEM').AsString := qryOrigem.FieldByName('COD_EMBALAGEM').AsString;
  qryGrava.ParamByName('COD_GRUPO').AsString := qryOrigem.FieldByName('COD_GRUPO').AsString;
  qryGrava.ParamByName('COD_PRODUTO').AsInteger := qryOrigem.FieldByName('COD_PRODUTO').AsInteger;
  qryGrava.ParamByName('COD_COR').AsString := qryOrigem.FieldByName('COD_COR').AsString;
  qryGrava.ParamByName('DES_COR').AsString := qryOrigem.FieldByName('DES_COR').AsString;
  qryGrava.ParamByName('NOM_COR').AsString := qryOrigem.FieldByName('NOM_COR').AsString;
  qryGrava.ParamByName('COD_TONALIDADE').AsString := fRetornaTonalidade(qryOrigem.FieldByName('COD_TONALIDADE').AsInteger);
  qryGrava.ParamByName('RGB').AsString := qryOrigem.FieldByName('RGB').AsString;

  If Not TStrUtils.fEmptyStr(qryGrava.ParamByName('RGB').AsString) Then
  Begin
    AColor := HexToTColor(qryGrava.ParamByName('RGB').AsString);

    qryGrava.ParamByName('RED').AsString := CorParaRGB(AColor, 'R');
    qryGrava.ParamByName('GREEN').AsString := CorParaRGB(AColor, 'G');
    qryGrava.ParamByName('BLUE').AsString := CorParaRGB(AColor, 'B');
  End
  Else
  Begin
    qryGrava.ParamByName('RED').AsString := '';
    qryGrava.ParamByName('GREEN').AsString := '';
    qryGrava.ParamByName('BLUE').AsString := '';
  End;

  qryGrava.ExecSQL;
end;

{ TQryProdutosTnp }

procedure TQryProdutosTmp.CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando);
begin
  if (Pos(qryOrigem.FieldByName('SITUACAO').AsString, 'A_a_')  <= 0) then
    Exit;

  qryGrava.ParamByName('COD_PRODUTO').AsString := AnsiUpperCase(qryOrigem.FieldByName('COD_PRODUTO').AsString);
  qryGrava.ParamByName('DES_PRODUTO').AsString := AnsiUpperCase(qryOrigem.FieldByName('DES_PRODUTO').AsString);
  qryGrava.ExecSQL;
end;

function TQryCoresTmp.CorParaRGB(AColor: TColor; strSigla: String): string;
var
  LValue: LongInt;
  R, G, B: Byte;
begin
  Result := '';

  LValue := colorToRGB(AColor);
  R := LValue;
  G := LValue shr 8;
  B := LValue shr 16;

  If strSigla = 'R' Then
    Result := IntToStr(R)
  Else If strSigla = 'G' Then
    Result := IntToStr(G)
  Else If strSigla = 'B' Then
    Result := IntToStr(B);
end;

function TQryCoresTmp.fRetornaTonalidade(intCodigo: Integer): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT DES_TONALIDADE FROM TMP_TONALIDADES  WHERE COD_TONALIDADE = :TONALIDADE  ';
  qryGen.ParamByName('TONALIDADE').AsInteger := intCodigo;
  qryGen.Open;

  Result := qryGen.FieldByName('DES_TONALIDADE').AsString;
end;

function TQryCoresTmp.HexToTColor(sColor: string): TColor;
begin
  Result :=
     RGB(
       StrToInt('$'+Copy(sColor, 1, 2)),
       StrToInt('$'+Copy(sColor, 3, 2)),
       StrToInt('$'+Copy(sColor, 5, 2))
     );
end;

{ TQryGruposTmp }

procedure TQryGruposTmp.CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando);
begin
  if (Pos(qryOrigem.FieldByName('SITUACAO').AsString, 'A_a_')  <= 0) then
    Exit;

  qryGrava.ParamByName('COD_GRUPO').AsString := qryOrigem.FieldByName('COD_GRUPO').AsString;
  qryGrava.ParamByName('DES_GRUPO').AsString := qryOrigem.FieldByName('DES_GRUPO').AsString;
  qryGrava.ExecSQL;
end;

{ TQryEmbalagensTmp }

procedure TQryEmbalagensTmp.CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando);
begin
  if (Pos(qryOrigem.FieldByName('SITUACAO').AsString, 'A_a_')  <= 0) Then
    Exit;

  qryGrava.ParamByName('COD_EMBALAGEM').AsString :=qryOrigem.FieldByName('COD_EMBALAGEM').AsString;
  qryGrava.ParamByName('VOLUME').AsFloat := qryOrigem.FieldByName('VOLUME').AsFloat;
  qryGrava.ExecSQL;
end;

{ TQryCoresColorantesTmp }

procedure TQryCoresColorantesTmp.CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando);
begin
end;

procedure TQryCoresColorantesTmp.ExecutarGeral(const qryOrigem: TUniQuery;
  const qryGrava: IDataSet; const gravando: IGravando);
Var
  qryConf: TUniQuery;
  FDDatabase  : TFDConnection;
  FDDriverLink: TFDPhysMySQLDriverLink;
  FDCursor    : TFDGUIxWaitCursor;
  qryCores    : TFDQuery;
  intContador : Integer;
  intQtd      : Integer;
  intTabela   : Integer;
begin
  intTabela := 1;

  qryConf := TAutcomTintaFactory.Get.fCriaQuery();

  FDriverID  := 'DriverID=MySQL';
  FDatabase  := 'Database=' + qryConf.Connection.Database;
  FUser_Name := 'User_Name=' + qryConf.Connection.Username;
  FPassword  := 'Password=' + qryConf.Connection.Password;
  FPort      := 'Port=' + IntToStr(qryConf.Connection.Port);
  FServer    := 'Server=' + qryConf.Connection.Server;

  FreeAndNil(qryConf);


  FDDatabase   := TFDConnection.Create(Nil);
  FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
  FDCursor     := TFDGUIxWaitCursor.Create(Nil);
  qryCores     := TFDQuery.Create(Nil);


  FDDatabase.Params.Add(FDatabase);
  FDDatabase.Params.Add(FUser_Name);
  FDDatabase.Params.Add(FPassword);
  FDDatabase.Params.Add(FPort);
  FDDatabase.Params.Add(FServer);
  FDDatabase.Params.Add(FDriverID);

  if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
  else
    FDDriverLink.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

  FDDatabase.Connected := True;

  qryCores.Connection := FDDatabase;
  qryCores.SQL.Text   :=  fSqlInsert(intTabela);

  While Not qryOrigem.Eof Do
  Begin
    qryCores.Params.ClearValues();
    qryCores.Params.ArraySize := 5000;
    intQtd := 0;

    For intContador := 0 To Pred(5000) Do
    Begin
      qryCores.ParamByName('COD_GRUPO').AsStrings[intContador] := qryOrigem.FieldByName('COD_GRUPO').AsString;
      qryCores.ParamByName('COD_PRODUTO').AsStrings[intContador] := qryOrigem.FieldByName('COD_PRODUTO').AsString;
      qryCores.ParamByName('COD_BASE').AsStrings[intContador] := qryOrigem.FieldByName('COD_BASE').AsString;
      qryCores.ParamByName('COD_EMBALAGEM').AsStrings[intContador] := qryOrigem.FieldByName('COD_EMBALAGEM').AsString;
      qryCores.ParamByName('COD_COR').AsStrings[intContador] := qryOrigem.FieldByName('COD_COR').AsString;
      qryCores.ParamByName('COD_COLORANTE').AsStrings[intContador] := qryOrigem.FieldByName('COD_COLORANTE').AsString;
      qryCores.ParamByName('QTDE').AsFloats[intContador] := qryOrigem.FieldByName('QTDE').AsFloat;
      qryCores.ParamByName('SEQ_ATUALIZACAO').AsIntegers[intContador] := qryOrigem.FieldByName('SEQ_ATUALIZACAO').AsInteger;

      If Not qryOrigem.Eof Then
        qryOrigem.Next
      Else
        Break;

      gravando.RegistrarProgresso(0, qryOrigem.RecNo, qryOrigem.RecordCount);
      Inc(intQtd, 1);
    End;

    qryCores.Execute(intQtd, 0);
  End;

  PreencherColorantes();

  FreeAndNil(FDDatabase);
  FreeAndNil(FDCursor);
  FreeAndNil(qryCores);
  FreeAndNil(FDDriverLink);
end;

function TQryCoresColorantesTmp.fSqlInsert(intTabela: Integer): String;
begin
  Result := '';
  Result := Result + ' INSERT INTO TMP_QRYCORESCOLORANTES' + ' (' ;
  Result := Result + '    COD_GRUPO,                      ';
  Result := Result + '    COD_PRODUTO,                    ';
  Result := Result + '    COD_BASE,                       ';
  Result := Result + '    COD_EMBALAGEM,                  ';
  Result := Result + '    COD_COR,                        ';
  Result := Result + '    COD_COLORANTE,                  ';
  Result := Result + '    QTDE,                           ';
  Result := Result + '    SEQ_ATUALIZACAO)                ';
  Result := Result + ' VALUES(                            ';
  Result := Result + '    :COD_GRUPO,                     ';
  Result := Result + '    :COD_PRODUTO,                   ';
  Result := Result + '    :COD_BASE,                      ';
  Result := Result + '    :COD_EMBALAGEM,                 ';
  Result := Result + '    :COD_COR,                       ';
  Result := Result + '    :COD_COLORANTE,                 ';
  Result := Result + '    :QTDE,                          ';
  Result := Result + '    :SEQ_ATUALIZACAO)               ';
end;


procedure TQryCoresColorantesTmp.PreencherColorantes;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE TMP_QRYCORESCOLORANTES A, TMP_QRYCOLORANTES B    ' +
                '   SET A.SIGLA_COLORANTE = B.SIGLA_COLORANTE             ' +
                ' WHERE                                                   ' +
                '   A.COD_COLORANTE = B.COD_COLORANTE;                    ';
  qryGen.ExecSQL;
end;

{ TQryBasesTmp }

procedure TQryBasesTmp.CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando);
begin
  if (Pos(qryOrigem.FieldByName('SITUACAO').AsString, 'A_a_')  <= 0) then
    Exit;

  qryGrava.ParamByName('COD_BASE').AsString := qryOrigem.FieldByName('COD_BASE').AsString;
  qryGrava.ParamByName('DES_BASE').AsString := qryOrigem.FieldByName('DES_BASE').AsString;
  qryGrava.ExecSQL;
end;

{ TQryProdutosBasesEmbalagensTmp }

procedure TQryProdutosBasesEmbalagensTmp.CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando);
begin
  if (Pos(qryOrigem.FieldByName('SITUACAO').AsString, 'A_a_')  <= 0) then
    Exit;

  qryGrava.ParamByName('COD_PRODUTO').AsString := qryOrigem.FieldByName('COD_PRODUTO').AsString;
  qryGrava.ParamByName('COD_BASE').AsString := qryOrigem.FieldByName('COD_BASE').AsString;
  qryGrava.ParamByName('COD_EMBALAGEM').AsString := qryOrigem.FieldByName('COD_EMBALAGEM').AsString;
  qryGrava.ExecSQL;
end;

{ TQryColorantesTmp }

procedure TQryColorantesTmp.CarregarTabela(const qryOrigem: TUniQuery; const qryGrava: IDataSet; const gravando: IGravando);
begin
  qryGrava.ParamByName('COD_COLORANTE').AsString := qryOrigem.FieldByName('COD_COLORANTE').AsString;
  qryGrava.ParamByName('SIGLA_COLORANTE').AsString := qryOrigem.FieldByName('SIGLA_COLORANTE').AsString;
  qryGrava.ParamByName('DES_COLORANTE').AsString := qryOrigem.FieldByName('DES_COLORANTE').AsString;
  qryGrava.ExecSQL;
end;

{ TQryMensagensTmp }

procedure TQryMensagensTmp.CarregarTabela(const qryOrigem: TUniQuery;
  const qryGrava: IDataSet; const gravando: IGravando);
begin
  if (Pos(qryOrigem.FieldByName('SITUACAO').AsString, 'A_a_')  <= 0) then
    Exit;

  qryGrava.ParamByName('COD_MENSAGEM').AsString := qryOrigem.FieldByName('COD_MENSAGEM').AsString;
  qryGrava.ParamByName('MENSAGEM').AsString     := qryOrigem.FieldByName('MENSAGEM').AsString;
  qryGrava.ExecSQL;
end;

{ TQryMensagensCoresBasesEmbalagensTmp }

procedure TQryMensagensCoresBasesEmbalagensTmp.CarregarTabela(
  const qryOrigem: TUniQuery; const qryGrava: IDataSet;
  const gravando: IGravando);
begin
  if (Pos(qryOrigem.FieldByName('SITUACAO').AsString, 'A_a_')  <= 0) then
    Exit;

  qryGrava.ParamByName('COD_MENSAGEM').AsString := qryOrigem.FieldByName('COD_MENSAGEM').AsString;
  qryGrava.ParamByName('COD_COR').AsString      := qryOrigem.FieldByName('COD_COR').AsString;
  qryGrava.ExecSQL;
end;


{ TQryTonalidades }

procedure TQryTonalidades.CarregarTabela(const qryOrigem: TUniQuery;
  const qryGrava: IDataSet; const gravando: IGravando);
begin
  qryGrava.ParamByName('COD_TONALIDADE').AsInteger := qryOrigem.FieldByName('COD_TONALIDADE').AsInteger;
  qryGrava.ParamByName('DES_TONALIDADE').AsString  := qryOrigem.FieldByName('DES_TONALIDADE').AsString;
  qryGrava.ExecSQL;
end;

end.
