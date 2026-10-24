unit TestFaturamento.Impostos.Servicos.Classe.Devolucao.DifalFCP;

interface

Uses
  TestFramework,
  Faturamento.Impostos.Servicos.Classe.Devolucao.DifalFCP,
  Faturamento.Impostos.Tipos.Servicos.Classe.Devolucao.DifalFcp,
  Faturamento.Impostos.Interfaces.Servicos.Classe.Devolucao.DifalFcp,
  untTestMyCampoTabela, untTestObjMyCampoTabela;

Type
  TestTServicoDevolucaoDifalFCP = class(TTestCase)
  strict private

  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCarregarDocumentoDevolvido;
    procedure TestDocumentoExiste_False;
    procedure TestDocumentoExiste_True;
    procedure TestCalcularProporcional_ProdutoSTTrue;
    procedure TestCalcularProporcional_ProdutoSTFalse;
    procedure TestRetornarResultado_ProdutoSTTrue;
    procedure TestRetornarResultado_ProdutoSTFalse;
  end;

implementation

{ TestTServicoDevolucaoDifalFCP }

procedure TestTServicoDevolucaoDifalFCP.SetUp;
begin
//  inherited;

  untTestMyCampoTabela.TMyCampoTabelaDefault.IniciarCamposDefault;

  objMyCampoTabelaAdd.Add('ICD_BCUFDE', 0);
  objMyCampoTabelaAdd.Add('ICD_PERFCP', 0);
  objMyCampoTabelaAdd.Add('ICD_ALQUFD', 0);
  objMyCampoTabelaAdd.Add('ICD_PERPAR', 0);
  objMyCampoTabelaAdd.Add('ICD_VALFCP', 0);
  objMyCampoTabelaAdd.Add('ICD_ALQINE', 0);
  objMyCampoTabelaAdd.Add('ICD_VALDES', 0);
  objMyCampoTabelaAdd.Add('ICD_VALORI', 0);
  objMyCampoTabelaAdd.Add('ICD_BASFCP', 0);
  objMyCampoTabelaAdd.Add('DET_QTDITE', 0);
  objMyCampoTabelaAdd.Add('DET_NUMDOC', '');

end;

procedure TestTServicoDevolucaoDifalFCP.TearDown;
begin
//  inherited;

end;

procedure TestTServicoDevolucaoDifalFCP.TestCalcularProporcional_ProdutoSTFalse;
var
  ReturnValue: IServicoClasseDevolucaoDifalFcp;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
begin

  objMyCampoTabelaAdd.Add('ICD_BCUFDE', 0);
  objMyCampoTabelaAdd.Add('ICD_PERFCP', 0);
  objMyCampoTabelaAdd.Add('ICD_ALQUFD', 0);
  objMyCampoTabelaAdd.Add('ICD_PERPAR', 0);
  objMyCampoTabelaAdd.Add('ICD_VALFCP', 0);
  objMyCampoTabelaAdd.Add('ICD_ALQINE', 0);
  objMyCampoTabelaAdd.Add('ICD_VALDES', 0);
  objMyCampoTabelaAdd.Add('ICD_VALORI', 0);
  objMyCampoTabelaAdd.Add('ICD_BASFCP', 0);
  objMyCampoTabelaAdd.Add('DET_QTDITE', 0);

  LParametros :=
    TParametrosClasseDevolucaoDifalFcp.New
      .CodigoDoCliente('00000001')
      .CodigoDoItem('00001')
      .NumeroDoDocumentoDeDevolucao('000100020003')
      .EspecieDoDocumentoDeDevolucao('NF')
      .EmpresaDoDocumentoDeDevolucao('001')
      .QuantidadeDoItem(1)
      .ProdutoST(False);

  ReturnValue :=
    TServicoClasseDevolucaoDifalFcp.New(LParametros).CarregarDocumentoDevolvido;

  CheckTrue(True);
end;

procedure TestTServicoDevolucaoDifalFCP.TestCalcularProporcional_ProdutoSTTrue;
var
  ReturnValue: IServicoClasseDevolucaoDifalFcp;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
begin

  objMyCampoTabelaAdd.Add('ICD_BCUFDE', 0);
  objMyCampoTabelaAdd.Add('ICD_PERFCP', 0);
  objMyCampoTabelaAdd.Add('ICD_ALQUFD', 0);
  objMyCampoTabelaAdd.Add('ICD_PERPAR', 0);
  objMyCampoTabelaAdd.Add('ICD_VALFCP', 0);
  objMyCampoTabelaAdd.Add('ICD_ALQINE', 0);
  objMyCampoTabelaAdd.Add('ICD_VALDES', 0);
  objMyCampoTabelaAdd.Add('ICD_VALORI', 0);
  objMyCampoTabelaAdd.Add('ICD_BASFCP', 0);
  objMyCampoTabelaAdd.Add('DET_QTDITE', 0);

  LParametros :=
    TParametrosClasseDevolucaoDifalFcp.New
      .CodigoDoCliente('00000001')
      .CodigoDoItem('00001')
      .NumeroDoDocumentoDeDevolucao('000100020003')
      .EspecieDoDocumentoDeDevolucao('NF')
      .EmpresaDoDocumentoDeDevolucao('001')
      .QuantidadeDoItem(1)
      .ProdutoST(True);

  ReturnValue :=
    TServicoClasseDevolucaoDifalFcp.New(LParametros)
      .CarregarDocumentoDevolvido
        .CalcularProporcional;

  CheckTrue(True);
end;

procedure TestTServicoDevolucaoDifalFCP.TestCarregarDocumentoDevolvido;
var
  ReturnValue: IServicoClasseDevolucaoDifalFcp;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
begin
  LParametros :=
    TParametrosClasseDevolucaoDifalFcp.New
      .CodigoDoCliente('00000001')
      .CodigoDoItem('00001')
      .NumeroDoDocumentoDeDevolucao('000100020003')
      .EspecieDoDocumentoDeDevolucao('NF')
      .EmpresaDoDocumentoDeDevolucao('001')
      .QuantidadeDoItem(1)
      .ProdutoST(False);

  ReturnValue :=
    TServicoClasseDevolucaoDifalFcp.New(LParametros).CarregarDocumentoDevolvido;

  CheckTrue(True);
end;

procedure TestTServicoDevolucaoDifalFCP.TestDocumentoExiste_False;
var
  ReturnValue: Boolean;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
begin
  LParametros :=
    TParametrosClasseDevolucaoDifalFcp.New
      .CodigoDoCliente('00000001')
      .CodigoDoItem('00001')
      .NumeroDoDocumentoDeDevolucao('000100020003')
      .EspecieDoDocumentoDeDevolucao('NF')
      .EmpresaDoDocumentoDeDevolucao('001')
      .QuantidadeDoItem(1)
      .ProdutoST(False);

  ReturnValue :=
    TServicoClasseDevolucaoDifalFcp.New(LParametros)
      .CarregarDocumentoDevolvido
        .DocumentoExiste;

  CheckTrue(ReturnValue = False);
end;

procedure TestTServicoDevolucaoDifalFCP.TestDocumentoExiste_True;
var
  ReturnValue: Boolean;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
begin
  objMyCampoTabelaAdd.Add('DET_NUMDOC', '12345679');

  LParametros :=
    TParametrosClasseDevolucaoDifalFcp.New
      .CodigoDoCliente('00000001')
      .CodigoDoItem('00001')
      .NumeroDoDocumentoDeDevolucao('000100020003')
      .EspecieDoDocumentoDeDevolucao('NF')
      .EmpresaDoDocumentoDeDevolucao('001')
      .QuantidadeDoItem(1)
      .ProdutoST(False);

  ReturnValue :=
    TServicoClasseDevolucaoDifalFcp.New(LParametros)
      .CarregarDocumentoDevolvido
        .DocumentoExiste;

  CheckTrue(ReturnValue = True);
end;

procedure TestTServicoDevolucaoDifalFCP.TestRetornarResultado_ProdutoSTFalse;
var
  ReturnValue: IResultadoClasseDevolucaoDifalFcp;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
begin
  objMyCampoTabelaAdd.Add('ICD_BCUFDE', 100);
  objMyCampoTabelaAdd.Add('ICD_PERFCP', 2);
  objMyCampoTabelaAdd.Add('ICD_ALQUFD', 17);
  objMyCampoTabelaAdd.Add('ICD_PERPAR', 100);
  objMyCampoTabelaAdd.Add('ICD_VALFCP', 2);
  objMyCampoTabelaAdd.Add('ICD_ALQINE', 12);
  objMyCampoTabelaAdd.Add('ICD_VALDES', 5);
  objMyCampoTabelaAdd.Add('ICD_VALORI', 0);
  objMyCampoTabelaAdd.Add('ICD_BASFCP', 100);
  objMyCampoTabelaAdd.Add('DET_QTDITE', 1);

  LParametros :=
    TParametrosClasseDevolucaoDifalFcp.New
      .CodigoDoCliente('00000001')
      .CodigoDoItem('00001')
      .NumeroDoDocumentoDeDevolucao('000100020003')
      .EspecieDoDocumentoDeDevolucao('NF')
      .EmpresaDoDocumentoDeDevolucao('001')
      .QuantidadeDoItem(1)
      .ProdutoST(False);

  ReturnValue :=
    TServicoClasseDevolucaoDifalFcp.New(LParametros)
      .CarregarDocumentoDevolvido
        .CalcularProporcional
          .RetornarResultado;

  CheckTrue((ReturnValue.BaseDestino = 100) And
            (ReturnValue.AliquotaFCP = 2) And
            (ReturnValue.AliquotaInternaEstadoDestino = 17) And
            (ReturnValue.PercentualProvisorioPartilha = 100) And
            (ReturnValue.ValorFCP = 2) And
            (ReturnValue.AliquotaInterestadualCalc = 12) And
            (ReturnValue.IcmsDestino = 5) And
            (ReturnValue.IcmsOrigem = 0) And
            (ReturnValue.BaseFCP = 100));
end;

procedure TestTServicoDevolucaoDifalFCP.TestRetornarResultado_ProdutoSTTrue;
var
  ReturnValue: IResultadoClasseDevolucaoDifalFcp;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
begin
  objMyCampoTabelaAdd.Add('ICD_BCUFDE', 100);
  objMyCampoTabelaAdd.Add('ICD_PERFCP', 2);
  objMyCampoTabelaAdd.Add('ICD_ALQUFD', 17);
  objMyCampoTabelaAdd.Add('ICD_PERPAR', 100);
  objMyCampoTabelaAdd.Add('ICD_VALFCP', 2);
  objMyCampoTabelaAdd.Add('ICD_ALQINE', 12);
  objMyCampoTabelaAdd.Add('ICD_VALDES', 5);
  objMyCampoTabelaAdd.Add('ICD_VALORI', 0);
  objMyCampoTabelaAdd.Add('ICD_BASFCP', 100);
  objMyCampoTabelaAdd.Add('DET_QTDITE', 1);

  LParametros :=
    TParametrosClasseDevolucaoDifalFcp.New
      .CodigoDoCliente('00000001')
      .CodigoDoItem('00001')
      .NumeroDoDocumentoDeDevolucao('000100020003')
      .EspecieDoDocumentoDeDevolucao('NF')
      .EmpresaDoDocumentoDeDevolucao('001')
      .QuantidadeDoItem(1)
      .ProdutoST(True);

  ReturnValue :=
    TServicoClasseDevolucaoDifalFcp.New(LParametros)
      .CarregarDocumentoDevolvido
        .CalcularProporcional
          .RetornarResultado;

  CheckTrue((ReturnValue.BaseDestino = 100) And
            (ReturnValue.AliquotaFCP = 2) And
            (ReturnValue.AliquotaInternaEstadoDestino = 17) And
            (ReturnValue.PercentualProvisorioPartilha = 100) And
            (ReturnValue.ValorFCP = 2) And
            (ReturnValue.AliquotaInterestadualCalc = 12) And
            (ReturnValue.IcmsDestino = 5) And
            (ReturnValue.IcmsOrigem = 0) And
            (ReturnValue.BaseFCP = 100));
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTServicoDevolucaoDifalFCP.Suite);

end.

