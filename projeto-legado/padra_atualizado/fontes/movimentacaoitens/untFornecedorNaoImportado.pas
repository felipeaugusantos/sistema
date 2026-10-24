unit untFornecedorNaoImportado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, untCadFornecedores, uniClientDataSet, Vcl.ComCtrls, cxGridCitel,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFornecedorNaoImportado = class(TfrmPaiConfirma)
    cxItensDBTableView1: TcxGridDBTableViewCitel;
    cxItensLevel1: TcxGridLevel;
    cxItens: TcxGrid;
    dsForn: TDataSource;
    cxItensDBTableView1Column1: TcxGridDBColumn;
    cxItensDBTableView1Column2: TcxGridDBColumn;
    cxItensDBTableView1Column3: TcxGridDBColumn;
    cxItensDBTableView1Column4: TcxGridDBColumn;
    cxItensDBTableView1Column5: TcxGridDBColumn;
    cxItensDBTableView1Column6: TcxGridDBColumn;
    cxItensDBTableView1Column7: TcxGridDBColumn;
    cxItensDBTableView1Column9: TcxGridDBColumn;
    cxItensDBTableView1Column10: TcxGridDBColumn;
    cxItensDBTableView1Column11: TcxGridDBColumn;
    cxItensDBTableView1Column12: TcxGridDBColumn;
    cxItensDBTableView1Column13: TcxGridDBColumn;
    cxItensDBTableView1Column14: TcxGridDBColumn;
    cxItensDBTableView1Column15: TcxGridDBColumn;
    cxItensDBTableView1Column16: TcxGridDBColumn;
    cxItensDBTableView1Column17: TcxGridDBColumn;
    cxItensDBTableView1Column18: TcxGridDBColumn;
    cxItensDBTableView1Column19: TcxGridDBColumn;
    cxItensDBTableView1Column20: TcxGridDBColumn;
    ProgressBar1: TProgressBar;
    procedure btnConfirmaClick(Sender: TObject);
  Protected
    FDataSet: TDataSet;
    { Private declarations }
    procedure pCarregarDadosNoCadastro;
    procedure pAbrirCadastro;
  public
    { Public declarations }
    class procedure fExibirFornecedoresNaoImportados(DataSet: TDataSet);
    class function fGetClientDataSetEstrutura: TUniClientDataSet;
  end;

var
  frmFornecedorNaoImportado: TfrmFornecedorNaoImportado;


implementation

uses
  untFuncoesSimples, Contabilidade.Funcoes, Contabilidade.Consultas,
  untCadClientes, untCadTransportadoras;

{$R *.dfm}

{ TfrmFornecedorNaoImportado }

procedure TfrmFornecedorNaoImportado.btnConfirmaClick(Sender: TObject);
  var
    intOpc: Integer;
    caAction: TCloseAction;
begin
  inherited;
  FDataSet.First;
  While (Not (FDataSet.Eof)) Do
  Begin
    intOpc := fMensagem('','Deseja fazer o cadastro para o Fornecedor [' + FDataSet.FieldByName('xNome').AsString + ']?',
               ['SIM', 'NÃO', 'PARAR'], 1);
    //Parar o processamento
    If intOpc = 3 Then
      Break;
    //Inicia o cadastro
    If intOpc = 1 Then
       pAbrirCadastro;
    //Pula para o proximo
    FDataSet.Next;
  End;
  If Assigned(frmCadFornecedores) Then
  Begin
    caAction := caFree;
    frmCadFornecedores.OnClose(Sender, caAction);
  End;
end;

class procedure TfrmFornecedorNaoImportado.fExibirFornecedoresNaoImportados(
  DataSet: TDataSet);
begin
  If (Assigned(DataSet)) And (Not(DataSet.IsEmpty)) Then
  begin
    If fMensagem('','Exite um ou mais fornecedores sem cadastro. Deseja fazer o cadastro?', ['SIM', 'NÃO'], 1) = 1 Then
    Begin
      pCriarFormularios(TfrmFornecedorNaoImportado, frmFornecedorNaoImportado);
      Try
         frmFornecedorNaoImportado.FDataSet := DataSet;
         //Se tiver mais de um registro exibe a tela com a lista dos fornecedores
         //Apenas inicia a importação;
         If DataSet.RecordCount > 1 Then
         Begin
           frmFornecedorNaoImportado.dsForn.DataSet := DataSet;
           frmFornecedorNaoImportado.cxItensDBTableView1.ApplyBestFit();
           frmFornecedorNaoImportado.Showmodal;
         End
         Else
           frmFornecedorNaoImportado.pAbrirCadastro;
      Finally
        FreeAndNil(frmCadFornecedores);
        FreeAndNil(frmFornecedorNaoImportado);
      End;
    end
  End;

end;

class function TfrmFornecedorNaoImportado.fGetClientDataSetEstrutura: TUniClientDataSet;
  procedure pAddFieldDefs(Name: string; DataType: TFieldType; Size: Integer; DisplayName: String);
    var
      intCountFields: Integer;
  Begin
    Result.FieldDefs.AddFieldDef;
    intCountFields := Result.FieldDefs.Count -1;
    Result.FieldDefs[intCountFields].Name        := Name;
    Result.FieldDefs[intCountFields].DataType    := DataType;
    Result.FieldDefs[intCountFields].Size        := Size;
    Result.FieldDefs[intCountFields].DisplayName := DisplayName;
  End;

Begin
  Result := TUniClientDataSet.Create(Nil);
  pAddFieldDefs('CNPJ',    ftString, 14 , 'CNPJ');
  pAddFieldDefs('CPF' ,    ftString, 11 , 'CPF');
  pAddFieldDefs('xNome',   ftString, 200, 'Nome');
  pAddFieldDefs('xFant',   ftString, 200, 'Nome Fantasia');
  pAddFieldDefs('xLgr',    ftString, 200, 'Logradoro');
  pAddFieldDefs('nro',     ftString, 10 , 'Número');
  pAddFieldDefs('xCpl',    ftString, 200, 'Complemento');
  pAddFieldDefs('xBairro', ftString, 200, 'Bairro');
  pAddFieldDefs('cMun',    ftString, 20 , 'Código Municipal');
  pAddFieldDefs('xMun',    ftString, 200, 'Cidade');
  pAddFieldDefs('UF',      ftString, 2  , 'UF');
  pAddFieldDefs('CEP',     ftString, 10 , 'CEP');
  pAddFieldDefs('cPais',   ftString, 10 , 'Código Pais');
  pAddFieldDefs('xPais',   ftString, 200, 'Pais');
  pAddFieldDefs('fone',    ftString, 14 , 'Fone');
  pAddFieldDefs('IE',      ftString, 25 , 'IE');
  pAddFieldDefs('IEST',    ftString, 30 , 'IEST');
  pAddFieldDefs('IM',      ftString, 30 , 'Inscrição Municipal');
  pAddFieldDefs('CNAE',    ftString, 30 , 'CNAE');
  Result.CreateDataSet;
end;


procedure TfrmFornecedorNaoImportado.pAbrirCadastro;
begin
  If Not Assigned(frmCadFornecedores) Then
  Begin

    try

      pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);

      frmCadFornecedores.fMskCon := fMskCon;
      frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
      frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
      frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
      frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
      frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
      frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
      frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
      frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
      frmCadFornecedores.FormShow(Self);

      pCarregarDadosNoCadastro;
      frmCadFornecedores.pIniciaCadExterno;

    finally
      frmCadFornecedores.fMskCon := Nil;
      frmCadFornecedores.fSemMascaraPlaNco := Nil;
      frmCadFornecedores.fPesqPlanoContabil := Nil;
      frmCadFornecedores.fCadastroRapidoCliente := Nil;
      frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
      frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
      pFreeAndNil(frmCadFornecedores);
    End;

  End;

end;

procedure TfrmFornecedorNaoImportado.pCarregarDadosNoCadastro;
begin

  frmCadFornecedores.btnIncluir.Click;
  frmCadFornecedores.DBECGCCPF.Field.AsString :=IIf(fEmptyStr(FDataSet.FieldByName('CNPJ').AsString), '2', '1');
  frmCadFornecedores.DBENUMCGC.Field.AsString :=IIf(fEmptyStr(FDataSet.FieldByName('CNPJ').AsString),
                                           FDataSet.FieldByName('CPF').AsString,
                                           FDataSet.FieldByName('CNPJ').AsString);
  frmCadFornecedores.DBENOMFOR.Field.AsString := FDataSet.FieldByName('xNome').AsString;
  frmCadFornecedores.DBENOMFAN.Field.AsString :=FDataSet.FieldByName('xFant').AsString;
  frmCadFornecedores.DBENUMCEP.Field.AsString :=FDataSet.FieldByName('CEP').AsString;
  frmCadFornecedores.DBECODCID.Field.AsString :=fCampoTabela('CID_CODCID', 'CADCID', ['CID_COIBGE'], [FDataSet.FieldByName('cMun').AsString]);
  frmCadFornecedores.DBEENDERE.Field.AsString :=FDataSet.FieldByName('xLgr').AsString;
  frmCadFornecedores.DBEENDNUM.Field.AsString :=FDataSet.FieldByName('nro').AsString;
  frmCadFornecedores.DBEENDCOM.Field.AsString :=FDataSet.FieldByName('xCpl').AsString;
  frmCadFornecedores.DBEBAIRRO.Field.AsString :=FDataSet.FieldByName('xBairro').AsString;
  frmCadFornecedores.DBEFONE01.Field.AsString :=FDataSet.FieldByName('fone').AsString;
  frmCadFornecedores.DBENUMIES.Field.AsString :=FDataSet.FieldByName('IE').AsString;
end;

end.
