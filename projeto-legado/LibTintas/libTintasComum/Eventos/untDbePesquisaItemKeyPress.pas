unit untDbePesquisaItemKeyPress;

interface

uses untBtnRestaurarPrecoEvento, untAutcomTintaFactory, Classes, untIAutcomTintaWrapper, SysUtils, untAbstractCadastro, untIDataSet, 
  untAbstractLibTintaControleVisualEvento, untILibTintaControleVisual, untTipoCadastro,untStrUtils;

type
  TDbePesquisaItemKeyPress = class(TAbstractLibTintaControleVisualEvento, ILibTintaControleVisualEvento)
  private
    dbeItem: string;
    dbePrecoCusto: string;
    dbeMargem: string;
    dbePrecoVenda: string;
    TTipo: TTipoCadastro;
    strSenderName : String;
  published
    constructor Create(const cadastro: TAbstractCadastro; const dbeItem: string;
      const dbePrecoCusto: string; const dbeMargem: string; const dbePrecoVenda: string; strSenderName : String = ''); reintroduce;
  published
    procedure OnKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

constructor TDbePesquisaItemKeyPress.Create(const cadastro: TAbstractCadastro;
  const dbeItem, dbePrecoCusto, dbeMargem, dbePrecoVenda: string; strSenderName : String = '');
begin
  inherited Create('OnKeyPress', cadastro);
  Self.dbeItem := dbeItem;
  Self.dbePrecoCusto := dbePrecoCusto;
  Self.dbeMargem := dbeMargem;
  Self.dbePrecoVenda := dbePrecoVenda;
  Self.TTipo := cadastro.GetTipoCadastro;
  Self.strSenderName := strSenderName;
end;

procedure TDbePesquisaItemKeyPress.OnKeyPress(Sender: TObject; var Key: Char);
var
  strSQL, strSQLWhere: String;
  qryCadIte : IDataSet;
  restaurar: TBtnRestaurarPrecoEvento;
  strRetorno: String;
  arrTitCol, arrConsultas, arrConsultasCampo: array of string;
  procedure pAddSubConsulta(SubConsulta, Campo: string);
  Begin
    SetLength(arrConsultas, Succ(Length(arrConsultas)));
    arrConsultas[High(arrConsultas)] := SubConsulta;

    SetLength(arrConsultasCampo, Succ(Length(arrConsultasCampo)));
    arrConsultasCampo[High(arrConsultasCampo)] := Campo;
  End;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
begin
  Try
    Try
      qryCadIte := TAutcomTintaFactory.Get.fGetDataSet;

      if TAutcomTintaFactory.Get.fEntraCons(Key) then
      begin
        Key := #0;
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   I.ITE_CODITE, '; pAddNomeColuna('Código');
        strSQL := strSQL + '   I.ITE_DESITE, '; pAddNomeColuna('Descrição');
        strSQL := strSQL + '   I.ITE_REFERE, '; pAddNomeColuna('Referência');
        strSQL := strSQL + '   I.ITE_CODUNI, '; pAddNomeColuna('Unidade');
        strSQL := strSQL + '   G.ITE_PREVE1, '; pAddNomeColuna('Preço de Venda');
        strSQL := strSQL + '   I.ITE_CODMAR, '; pAddNomeColuna('Cód. Marca');
        strSQL := strSQL + '   M.MAR_DESMAR, '; pAddNomeColuna('Marca');
        strSQL := strSQL + '   ESTADO, ' ; pAddNomeColuna('Ativo');
        pAddSubConsulta('IF(I.ITE_ITEATI = "S", "ATIVO", "INATIVO")', 'ESTADO');

        strSQL := strSQL + '   I.ITE_CODSIM, '; pAddNomeColuna('Similar');
        strSQL := strSQL + '   G.ITE_SALDOS, '; pAddNomeColuna('Saldo');
        strSQL := strSQL + '   ITE_PRECUS  , '; pAddNomeColuna('Preço Custo');

        strSQL := strSQL + '   ULTVEN, '; pAddNomeColuna('Última Venda');

        strSQL := strSQL + '   I.ITE_CODFAB, '; pAddNomeColuna('Código de Fábrica');

        strSQL := strSQL + '   I.AUTOINCREM  ';

        pAddSubConsulta('DATEDIFF(CURRENT_DATE, IFNULL(G.ITE_DTAUVE, CURRENT_DATE))', 'ULTVEN');
        strSQL := strSQL + ' FROM  ';
        strSQL := strSQL + '    CADITE I ';
        strSQL := strSQL + '    INNER JOIN ITEGER G ';
        strSQL := strSQL + '      ON I.ITE_CODITE = G.ITE_CODITE ';
        strSQL := strSQL + '    INNER JOIN CADMAR M  ';
        strSQL := strSQL + '      ON I.ITE_CODMAR = M.MAR_CODMAR ';
        strSQLWhere := strSQLWhere + '  WHERE G.ITE_IMPLIS = "S" ';
        strSQLWhere := strSQLWhere + '    AND I.ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"     ';
        strSQLWhere := strSQLWhere + '    AND IFNULL(I.ITE_ITEATI,"N") = "S"  ';

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));

        If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
          strSQLWhere := strSQLWhere + '  AND I.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));


          If Self.TTipo = ttBases then
            strSQLWhere := strSQLWhere + '   AND IFNULL(I.ITE_ITEBAS,"N") = "S" '
          Else If Self.TTipo = ttColorantes then
            strSQLWhere := strSQLWhere + '   AND IFNULL(I.ITE_ITEPIG,"N") = "S" ';

          strSQLWhere := strSQLWhere + '  AND G.ITE_CODEMP = ' + QuotedStr(TAutcomTintaFactory.Get.GetCodEmp);

        TAutcomTintaFactory.Get.fSenderName(Self.strSenderName);

        If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM',
                                                 'CADITE', Self.strSenderName, 'Consulta Item', qryCadIte, arrConsultas, arrConsultasCampo) Then
        Begin
          GetFieldByControle(dbeItem).AsString := TStrUtils.fStrZero(qryCadIte.FieldByName('ITE_CODITE').AsString, TAutcomTintaFactory.Get.fTamCodIte());
          If cadastro.fValidaCampos(tela, cadastro.GetNomeCampoItem, tela[dbeItem]['Text'].Value, strRetorno) Then
            tela.SelectNext;

          If (Not TStrUtils.fEmptyStr(dbePrecoCusto)) And (Not TStrUtils.fEmptyStr(dbeMargem)) And (Not TStrUtils.fEmptyStr(dbePrecoVenda)) Then
          Begin
            restaurar := TBtnRestaurarPrecoEvento.Create(cadastro, dbeItem, dbePrecoCusto, dbeMargem, dbePrecoVenda);
            restaurar.SetTelaCadLibTintas(tela);
            restaurar.OnClick(Sender);
          End;
        End;
      end;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(restaurar) then FreeAndNil(restaurar);
  End;
end;
end.
