unit untDbePesquisaItemKeyPress;

interface

uses untBtnRestaurarPrecoEvento, untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untAbstractCadastro, untIDataSet, 
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual;

type
  TDbePesquisaItemKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    dbeItem: string;
    dbePrecoCusto: string;
    dbeMargem: string;
    dbePrecoVenda: string;
  published
    constructor Create(const cadastro: TAbstractCadastro; const dbeItem: string;
      const dbePrecoCusto: string; const dbeMargem: string; const dbePrecoVenda: string); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

constructor TDbePesquisaItemKeyPress.Create(const cadastro: TAbstractCadastro;
  const dbeItem, dbePrecoCusto, dbeMargem, dbePrecoVenda: string);
begin
  inherited Create('OnKeyPress', cadastro);
  Self.dbeItem := dbeItem;
  Self.dbePrecoCusto := dbePrecoCusto;
  Self.dbeMargem := dbeMargem;
  Self.dbePrecoVenda := dbePrecoVenda;  
end;

procedure TDbePesquisaItemKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  stlCamIndIte: TStringList;
  stlDesIndIte: TStringList;
  strSQL: String;
  qryCadIte : IDataSet;
  restaurar: TBtnRestaurarPrecoEvento;
begin
  stlCamIndIte := nil;
  stlDesIndIte := nil;
  restaurar := nil;
  Try
    Try
      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        stlCamIndIte := TStringList.Create;
        stlDesIndIte := TStringList.Create;

        strSQL :=
          ' SELECT                                                   ' +
          '   I.ITE_CODITE AS "Codigo"                               ' +
          '   , I.ITE_DESITE AS "Descrição"                          ' +
          '   , I.ITE_REFERE AS "Referência"                         ' +
          '   , I.ITE_CODUNI AS "Unidade"                            ' +
          '   , G.ITE_PREVE1 AS "Preço de Venda"                     ' +
          '   , I.ITE_CODMAR AS "Cód. Marca"                         ' +
          '   , M.MAR_DESMAR AS "Marca"                              ' +
          '   , I.AUTOINCREM AS "AUTOINCREM"                         ' +
          '   , IF(                                                  ' +
          '     I.ITE_ITEATI = "S"                                   ' +
          '     , "ATIVO"                                            ' +
          '     , "INATIVO"                                          ' +
          '   ) AS "Ativo"                                           ' +
          '   , I.ITE_CODSIM AS "Similar"                            ' +
          '   , G.ITE_SALDOS AS "Saldo"                              ' +
          '   , ITE_PRECUS AS "Preço Custo"                          ' +
          '   , DATEDIFF(CURRENT_DATE, ITE_DTAUVE) AS "Última Venda" ' +
          ' FROM                                                     ' +
          '   CADITE I                                               ' +
          '   INNER JOIN ITEGER G                                    ' +
          '     ON I.ITE_CODITE = G.ITE_CODITE                       ' +
          '   INNER JOIN CADMAR M                                    ' +
          '     ON I.ITE_CODMAR = M.MAR_CODMAR                       ' +
          ' WHERE G.ITE_IMPLIS = "S"                                 ' +
          '   AND G.ITE_CODEMP = ' + QuotedStr(TAutcomTintaFactory.Get.GetCodEmp);

        stlCamIndIte.Add('I.ITE_DESITE');
        stlCamIndIte.Add('I.ITE_CODITE');
        stlCamIndIte.Add('I.ITE_REFERE');

        stlDesIndIte.Add('Descrição');
        stlDesIndIte.Add('Codigo');
        stlDesIndIte.Add('Referência');

        If TAutcomTintaFactory.Get.pConsultaComp(qryCadIte,
          'CADITE',
          strSQL,
          stlCamIndIte.Text,
          stlDesIndIte.Text) Then
        Begin
          GetFieldByControle(dbeItem).AsString := qryCadIte.FieldByName('ITE_CODITE').AsString;
          cadastro.CarregarDescricoes(tela);
          tela.SelectNext;
          restaurar := TBtnRestaurarPrecoEvento.Create(cadastro, dbeItem, dbePrecoCusto, dbeMargem, dbePrecoVenda);
          restaurar.SetTelaCadLibTintas(tela);
          restaurar.OnClick(Sender);
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlCamIndIte) then FreeAndNil(stlCamIndIte);
    if Assigned(stlDesIndIte) then FreeAndNil(stlDesIndIte);
    if Assigned(restaurar) then FreeAndNil(restaurar);
  End;
end;
end.
