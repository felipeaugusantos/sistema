unit ImportacaoDados.Model.CadLocEqu;

interface

uses
  ImportacaoDados.Interfaces, ImportacaoDados.Model.ModeloArquivo,
  Classes, SysUtils, cxProgressBar, System.Generics.Collections, DB, Uni, Variants;

Type

  TModeloImportacaoAcessoriosEquLocacao = class;

  TModeloImportacaoEquipamentoLocacao = class(TModeloArquivoImportacao)
  private
    FObjModeloAcessorios: IModeloArquivoImportacao;
    FObjModeloNegociacao: IModeloArquivoImportacao;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure pDefineCamposPadrao; override;
  End;

  TModeloImportacaoAcessoriosEquLocacao = class(TModeloArquivoImportacao)
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure pDefineCamposPadrao; override;
  End;

  TModeloImportacaoNegociacaoEquLocacao = class(TModeloArquivoImportacao)
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure pDefineCamposPadrao; override;
  End;

const

  cstCadEql = 'CADEQL';
  cstCodigo = 'EQL_CODIGO';
  cstStatus = 'EQL_STATUS';
  cstDescri = 'EQL_DESCRI';
  cstNSerie = 'EQL_NSERIE';
  cstDtaAqu = 'EQL_DTAAQU';
  cstDtulmn = 'EQL_DTULMN';
  cstValAqu = 'EQL_VALAQU';
  cstValLoc = 'EQL_VALLOC';
  cstVlLocD = 'EQL_VLLOCD';
  cstVlLocM = 'EQL_VLLOCM';
  cstRpUlMn = 'EQL_RPULMN';
  cstGarant = 'EQL_GARANT';
  cstAnoFab = 'EQL_ANOFAB';
  cstModelo = 'EQL_MODELO';
  cstDtaVen = 'EQL_DTAVEN';
  cstLocFis = 'EQL_LOCFIS';
  cstCodIte = 'EQL_CODITE';
  cstEspEcf = 'EQL_ESPECF';
  cstDscGer = 'EQL_DSCGER';
  cstDscSge = 'EQL_DSCSGE';
  cstDscVen = 'EQL_DSCVEN';
  cstVlrCau = 'EQL_VLRCAU';

  cstTabAce = 'EQUACL';
  cstCodEql = 'EQA_CODEQU';
  cstCodAcl = 'EQA_CODACL';
  cstQtdAcl = 'EQA_QTDACL';
  cstSeqEql = 'EQA_SEQEQU';
  cstSeqAcl = 'EQA_SEQACL';
  cstCodEqa = 'EQA_CODIGO';

  cstGrpCod = cstTabAce + '_' + cstCodAcl;
  cstGrpQtd = cstTabAce + '_' + cstQtdAcl;

  cstTabNeg = 'EQUNGD';
  cstCodEqu = 'EQN_CODEQU';
  cstQtdDia = 'EQN_QTDDIA';
  cstVlrTot = 'EQN_VLRTOT';
  cstVlrDia = 'EQN_VLRDIA';
  cstSeqEqlN= 'EQN_SEQEQU';

  cstGrpCodN = cstTabNeg + '_' + cstCodEqu;
  cstGrpQtdN = cstTabNeg + '_' + cstQtdDia;
  cstGrpVlrN = cstTabNeg + '_' + cstVlrTot;

  arrCamposCadLocEqu: array of string = [cstCodigo,  // 0
                                         cstStatus,  // 1
                                         cstDescri,  // 2
                                         cstNSerie,  // 3
                                         cstDtaAqu,  // 4
                                         cstDtulmn,  // 5
                                         cstValAqu,  // 6
                                         cstValLoc,  // 7
                                         cstVlLocD,  // 8
                                         cstVlLocM,  // 9
                                         cstRpUlMn,  // 10
                                         cstGarant,  // 11
                                         cstAnoFab,  // 12
                                         cstModelo,  // 13
                                         cstDtaVen,  // 14
                                         cstLocFis,  // 15
                                         cstCodIte,  // 16
                                         cstEspEcf,  // 17
                                         cstDscGer,  // 18
                                         cstDscSge,  // 19
                                         cstDscVen,  // 20
                                         cstVlrCau,  // 21
                                         cstGrpCod,  // 22
                                         cstGrpQtd]; // 23


  arrCamposEquAcl: array of string = [cstCodEql,   // 0
                                      cstCodAcl,   // 1
                                      cstQtdAcl,   // 2
                                      cstSeqEql,   // 3
                                      cstSeqAcl,   // 4
                                      cstCodEqa];  // 5

  arrCamposNegEql: array of string = [cstCodEqu,  // 0
                                      cstQtdDia,  // 1
                                      cstVlrTot,  // 2
                                      cstVlrDia,  // 3
                                      cstSeqEqlN]; // 4

implementation

{ TModeloImportacaoEquipamentoLocacao }

constructor TModeloImportacaoEquipamentoLocacao.Create;
begin
  inherited;

  Self.strNomeTabela := cstCadEql ;
  Self.Tipo := tpCadLocEqu;

  pDefineCamposPadrao;

  FObjModeloAcessorios := TModeloImportacaoAcessoriosEquLocacao.Create;
  FObjModeloAcessorios.fCarregarCamposPadrao;

  FObjModeloNegociacao := TModeloImportacaoNegociacaoEquLocacao.Create;
  FObjModeloNegociacao.fCarregarCamposPadrao;

  fAddModeloTabela(FObjModeloAcessorios);
  fAddModeloTabela(FObjModeloNegociacao);

  Self.Editavel := False;
end;

destructor TModeloImportacaoEquipamentoLocacao.Destroy;
begin
  inherited;

end;

procedure TModeloImportacaoEquipamentoLocacao.pDefineCamposPadrao;
begin
  Self.pLimparCampos;
  Self.CamposPadrao.Clear;

  Self.CamposPadrao.Add(fAdicionarCampo(cstCodigo, 'Código',                   'A',  'N', ftString,  5, False, True));
  Self.CamposPadrao.Add(fAdicionarCampo(cstStatus, 'Situação',                 'B',  'S', ftString,  1));
  Self.CamposPadrao.Add(fAdicionarCampo(cstDescri, 'Descrição',                'C',  'S', ftString,  70));
  Self.CamposPadrao.Add(fAdicionarCampo(cstNSerie, 'Nro.Série',                'D',  'S', ftString,  20));
  Self.CamposPadrao.Add(fAdicionarCampo(cstDtaAqu, 'Data Aquisição',           'E',  'N', ftDateTime,10));
  Self.CamposPadrao.Add(fAdicionarCampo(cstDtulmn, 'Data Últ.Manutenção',      'F',  'N', ftDateTime,10));
  Self.CamposPadrao.Add(fAdicionarCampo(cstValAqu, 'Valor Aquisição',          'G',  'N', ftFloat ,  15));
  Self.CamposPadrao.Add(fAdicionarCampo(cstValLoc, 'Valor Locação Hora',       'H',  'S', ftFloat ,  15));
  Self.CamposPadrao.Add(fAdicionarCampo(cstVlLocD, 'Valor Locação Diária',     'I',  'S', ftFloat ,  15));
  Self.CamposPadrao.Add(fAdicionarCampo(cstVlLocM, 'Valor Locação Mensal',     'J',  'S', ftFloat ,  15));
  Self.CamposPadrao.Add(fAdicionarCampo(cstRpUlMn, 'Responsável Ult.Man.',     'K',  'N', ftString,  70));
  Self.CamposPadrao.Add(fAdicionarCampo(cstGarant, 'Garantia em meses',        'L',  'S', ftInteger, 10));
  Self.CamposPadrao.Add(fAdicionarCampo(cstAnoFab, 'Ano Fabricação',           'M',  'N', ftInteger, 10));
  Self.CamposPadrao.Add(fAdicionarCampo(cstModelo, 'Modelo',                   'M',  'N', ftString,  40));
  Self.CamposPadrao.Add(fAdicionarCampo(cstDtaVen, 'Data Venda',               'O',  'N', ftDateTime,10));
  Self.CamposPadrao.Add(fAdicionarCampo(cstLocFis, 'Localização Física',       'P',  'N', ftString,  30));
  Self.CamposPadrao.Add(fAdicionarCampo(cstCodIte, 'Produto',                  'Q',  'S', ftString,  5));
  Self.CamposPadrao.Add(fAdicionarCampo(cstEspEcf, 'Especificações',           'R',  'N', ftString,  250));
  Self.CamposPadrao.Add(fAdicionarCampo(cstDscGer, 'Desc. Max.Gerente %',      'S',  'N', ftFloat ,  15));
  Self.CamposPadrao.Add(fAdicionarCampo(cstDscSge, 'Desc. Max.Subgerente %',   'T',  'N', ftFloat ,  15));
  Self.CamposPadrao.Add(fAdicionarCampo(cstDscVen, 'Desc. Max.Vendedor %',     'U',  'N', ftFloat ,  15));
  Self.CamposPadrao.Add(fAdicionarCampo(cstVlrCau, 'Valor Caução'        ,     'V',  'N', ftFloat ,  15));
  Self.CamposPadrao.Add(fAdicionarCampo(cstGrpCod, 'Grupo Cód. Acessório do Equipamento','W',  'N', ftString,  0, True));
  Self.CamposPadrao.Add(fAdicionarCampo(cstGrpQtd, 'Grupo Quantidade do Acessório'      ,'X',  'N', ftString,  0, True));
  Self.CamposPadrao.Add(fAdicionarCampo(cstGrpQtdN, 'Grupo Quantidade de dias Negociação' ,'Y',  'N', ftString,  0, True));
  Self.CamposPadrao.Add(fAdicionarCampo(cstGrpVlrN, 'Grupo Valor total para Negociação' ,'Z',  'N', ftString,  0, True));
end;

{ TModeloImportacaoAcessoriosEquLocacao }

constructor TModeloImportacaoAcessoriosEquLocacao.Create;
begin
  inherited;

  Self.strNomeTabela := cstTabAce;
  pDefineCamposPadrao;
end;

destructor TModeloImportacaoAcessoriosEquLocacao.Destroy;
begin

  inherited;
end;

procedure TModeloImportacaoAcessoriosEquLocacao.pDefineCamposPadrao;
begin
  inherited;

  Self.pLimparCampos;
  Self.CamposPadrao.Clear;

  Self.CamposPadrao.Add(fAdicionarCampo(cstCodEql, 'Cód.Equip.' ,              '-',  'N', ftString,  5));
  Self.CamposPadrao.Add(fAdicionarCampo(cstCodAcl, 'Código Ace.',              'W',  'S', ftString,  5));
  Self.CamposPadrao.Add(fAdicionarCampo(cstQtdAcl, 'Quantidade' ,              'X',  'S', ftInteger,  10));
  Self.CamposPadrao.Add(fAdicionarCampo(cstSeqEql, 'Seq.Equipamento',          '-',  'N', ftString, 20, False, False, True));
  Self.CamposPadrao.Add(fAdicionarCampo(cstSeqAcl, 'Seq.Acessório',            '-',  'S', ftString, 20, False, False, True));
end;

{ TModeloImportacaoNegociacaoEquLocacao }

constructor TModeloImportacaoNegociacaoEquLocacao.Create;
begin
  inherited;

  Self.strNomeTabela := cstTabNeg;
  pDefineCamposPadrao;

end;

destructor TModeloImportacaoNegociacaoEquLocacao.Destroy;
begin

  inherited;
end;

procedure TModeloImportacaoNegociacaoEquLocacao.pDefineCamposPadrao;
begin
  inherited;

  Self.pLimparCampos;
  Self.CamposPadrao.Clear;

  Self.CamposPadrao.Add(fAdicionarCampo(cstCodEqu, 'Cód.Equip.' ,              '-',  'N', ftString,  5));
  Self.CamposPadrao.Add(fAdicionarCampo(cstQtdDia, 'Qtd.Dias  ',               'Y',  'S', ftInteger,  10));
  Self.CamposPadrao.Add(fAdicionarCampo(cstVlrTot, 'Vlr.Total' ,               'Z',  'S', ftFloat,  10));
  Self.CamposPadrao.Add(fAdicionarCampo(cstVlrDia, 'Vlr.Diária' ,              'AA', 'N', ftFloat,  10, False, False, True));
  Self.CamposPadrao.Add(fAdicionarCampo(cstSeqEqlN, 'Seq.Equipamento',         '-',  'N', ftString, 20, False, False, True));
end;

end.


