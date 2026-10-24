{**************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta Dupont *}
{***********************************************************************AC*}
unit untGravandoExecucaoDupontBases;

interface

uses
  untAbstractGravandoExecucaoDupont, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, XMLDoc, XMLIntf, UniClientDataSet, DB, TypInfo;

type
  TGravandoExecucaoDupontBases = class(TAbstractGravandoExecucaoDupont)
  private
    function fQtdEmbalagemMl(strEmbalagem: String): String;
    function fXmlProdutoToDataSet(const gravando: IGravando): TUniClientDataSet;
    function fXmlToDataSet(strArquivo: String; const gravando: IGravando): TUniClientDataSet;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untIConfTinta;

{ TGravandoExecucaoDupontBases }

procedure TGravandoExecucaoDupontBases.Executar(const gravando: IGravando);
var
  qryDestino     : IDataSet;
  xmlGen         : TXMLDocument;
  xmlNoData      : IXMLNode;
  xmlRegistro    : IXMLNode;
  intQtdAtual    : Integer;
  intQtdRegistros: Integer;
  cdsDesBas      : TUniClientDataSet;
//  PClass: TPersistentClass;
  AComp: TComponent;
//  LForm: TComponentClass;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath(ttBases)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

  //    LForm:= TComponentClass(PClass).Create(Self) as TCustomForm;

      AComp := TComponentClass.Create(nil);

      xmlGen := TXMLDocument.Create(AComp);
      xmlGen.FileName := GetPath(ttBases,0);
      xmlGen.Active := True;

      xmlNoData := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');

      If Not Assigned(xmlNoData) Then
      Begin
        gravando.Texto := Format('O arquivo %s não está no formato esperado', [GetPath(ttBases,0)]);
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DUP_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      Try
        Try
          if gravando.Status <> sgGravando then
            Exit;

          qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
          qryDestino.SQL := 'SELECT * FROM DUP_CADBAS';
          qryDestino.Open;

          intQtdAtual := 1;
          intQtdRegistros := xmlNoData.ChildNodes.Count;

          xmlRegistro := xmlNoData.ChildNodes.First;
          gravando.Texto := 'Cadastrando bases...';

          cdsDesBas := fXmlProdutoToDataSet(gravando);

          If Not Assigned(cdsDesBas) Then
            Exit;

          While Assigned(xmlRegistro) Do
          Begin
            if gravando.Status <> sgGravando then
              Exit;

            If Not qryDestino.Locate('BAS_CODBAS;BAS_TIPO__', VarArrayOf([xmlRegistro.Attributes['VCOMPONENTE'],
              xmlRegistro.Attributes['VTIPO']]), []) Then
            Begin
              qryDestino.Insert;
              qryDestino.FieldByName('BAS_CODBAS').AsString := xmlRegistro.Attributes['VCOMPONENTE'];
              qryDestino.FieldByName('BAS_TIPO__').AsString := xmlRegistro.Attributes['VTIPO'];
              qryDestino.FieldByName('BAS_LINHA_').AsString := xmlRegistro.Attributes['VLINHA_PRODUTO'];
              qryDestino.FieldByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
              qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('DUP_CADBAS', TAutcomTintaFactory.Get.GetCodEmp);
              qryDestino.FieldByName('BAS_PESESP').AsFloat :=  fFormataFloatDupont(xmlRegistro.Attributes['VPESO']);

              If cdsDesBas.Locate('COMPONENTE', xmlRegistro.Attributes['VCOMPONENTE'], []) Then
              Begin
                qryDestino.FieldByName('BAS_DESBAS').AsString := cdsDesBas.FieldByName('DSCR_COMPONENTE').AsString;
                qryDestino.FieldByName('BAS_EMBALA').AsFloat :=
                  TAutcomTintaFactory.Get.fStrToFloat(Copy(cdsDesBas.FieldByName('EMBALAGEM').AsString, 1, Length(cdsDesBas.FieldByName('EMBALAGEM').AsString) - 3));
                qryDestino.FieldByName('BAS_QTDEMB').AsString := fQtdEmbalagemMl(Copy(cdsDesBas.FieldByName('EMBALAGEM').AsString, 1, Length(cdsDesBas.FieldByName('EMBALAGEM').AsString) - 3));

                If (cdsDesBas.FieldByName('UM').AsString = 'ML') Then
                Begin
                  qryDestino.FieldByName('BAS_PESGRA').AsString := 'N';
                End
                Else
                Begin
                  qryDestino.FieldByName('BAS_PESGRA').AsString := 'S';
                End;
              End
              else
              begin
                qryDestino.FieldByName('BAS_PESGRA').AsString := 'N';
              end;

              qryDestino.Post;
            End;
            gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
            intQtdAtual := intQtdAtual + 1;

            xmlRegistro := xmlRegistro.NextSibling;
          End;

        Except
          on E: Exception do
          begin
            gravando.Cancelar;
            gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          end;
        End;
      Finally

      End;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoDupontBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TGravandoExecucaoDupontBases.fQtdEmbalagemMl(
  strEmbalagem: String): String;
begin
  Result := Trim(strEmbalagem) + ' ML';
end;

function TGravandoExecucaoDupontBases.fXmlProdutoToDataSet(const gravando: IGravando): TUniClientDataSet;
  Var
    strPat: String;

    xmlGen: TXMLDocument;

    xmlNoInsert: IXMLNode;
    xmlRegistro: IXMLNode;

    intQtdRegistros: Integer;
    intQtdAtual: Integer;

    AComp: TComponent;
begin
  strPat := conf.fGet('PATDUP');
  strPat := strPat + '\Produto.xml';

  If Not FileExists(strPat) Then
  Begin
    gravando.Texto := Format('O arquivo %s não existe', [strPat]);
    gravando.Cancelar;
    Result := nil;
    Exit;
  End;

  Try
    AComp := TComponentClass.Create(nil);

    xmlGen := TXMLDocument.Create(AComp);
    xmlGen.FileName := strPat;
    xmlGen.Active := True;

    Result := fXmlToDataSet(strPat, gravando);
    Result.Open;

    xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data').ChildNodes.FindNode('insert');
    xmlRegistro := xmlNoInsert.ChildNodes.First;

    If Not Assigned(xmlRegistro) Then
    Begin
      gravando.Texto := Format('O arquivo %s não está no formato esperado', [strPat]);
      gravando.Cancelar;
      Result := nil;
      Exit;
    End;

    intQtdRegistros := xmlNoInsert.ChildNodes.Count;
    intQtdAtual := 1;

    While (Assigned(xmlRegistro)) Do
    Begin

      If xmlRegistro.Attributes['TIPO_PRODUTO'] <> 'EMBALAGEM' Then
      Begin
        Result.Insert;

        Result.FieldByName('LINHA_PRODUTO').Value := xmlRegistro.Attributes['LINHA_PRODUTO'];
        Result.FieldByName('TIPO_PRODUTO').Value := xmlRegistro.Attributes['TIPO_PRODUTO'];
        Result.FieldByName('PRODUTO').Value := xmlRegistro.Attributes['PRODUTO'];
        Result.FieldByName('DSCR_COMPONENTE').Value := xmlRegistro.Attributes['DSCR_COMPONENTE'];
        Result.FieldByName('LITOGRAFIA').Value := xmlRegistro.Attributes['LITOGRAFIA'];
        Result.FieldByName('COD_EMBALAGEM').Value := xmlRegistro.Attributes['COD_EMBALAGEM'];
        Result.FieldByName('EMBALAGEM').Value := xmlRegistro.Attributes['EMBALAGEM'];
        Result.FieldByName('VALOR').Value := xmlRegistro.Attributes['VALOR'];
        Result.FieldByName('VALOR_GRAMA').Value := xmlRegistro.Attributes['VALOR_GRAMA'];
        Result.FieldByName('TIPO').Value := xmlRegistro.Attributes['TIPO'];
        Result.FieldByName('UM').Value := xmlRegistro.Attributes['UM'];
        Result.FieldByName('COMPONENTE').Value := xmlRegistro.Attributes['COMPONENTE'];
        Result.FieldByName('TIPO_PRODUTO_ESP').Value := xmlRegistro.Attributes['TIPO_PRODUTO_ESP'];

        Result.Post;
      End;

      xmlRegistro := xmlRegistro.NextSibling;
      gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
      intQtdAtual := intQtdAtual + 1;
    End;
  Finally
    FreeAndNil(xmlGen);
  End;
end;

function TGravandoExecucaoDupontBases.fXmlToDataSet(
  strArquivo: String; const gravando: IGravando): TUniClientDataSet;
  Var
    xmlGen: TXMLDocument;
    xmlNoElementType: IXMLNode;
    xmlRegistro: IXMLNode;

    nomeCampo: String;
    tipoCampo: TFieldType;
    tamanhoCampo: Integer;
    requerido: Boolean;
    AComp: TComponent;
begin

  If Not FileExists(strArquivo) Then
  Begin
    gravando.Texto := Format('O arquivo %s não existe', [strArquivo]);
    gravando.Cancelar;
    Result := nil;
    Exit;
  End;

  Try
    AComp := TComponentClass.Create(nil);

    xmlGen := TXMLDocument.Create(AComp);
    xmlGen.FileName := strArquivo;
    xmlGen.Active := True;

    xmlNoElementType := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('Schema').ChildNodes.FindNode('ElementType');

    If Not Assigned(xmlNoElementType) Then
    Begin
      gravando.Texto := Format('O arquivo %s não está no formato esperado', [strArquivo]);
      gravando.Cancelar;
      Result := nil;
      Exit;
    End;

    Result := TUniClientDataSet.Create(Nil);
    xmlRegistro := xmlNoElementType.ChildNodes.FindNode('AttributeType');

    While (Assigned(xmlRegistro)) Do
    Begin

      If xmlRegistro.Attributes['name'] = Null Then
        Break;

      nomeCampo := xmlRegistro.Attributes['name'];

      If (xmlRegistro.ChildNodes.FindNode('datatype').Attributes['dt:type'] = 'string') Then
      Begin
        tipoCampo := ftString;
        tamanhoCampo := xmlRegistro.ChildNodes.FindNode('datatype').Attributes['dt:maxLength'];
      End
      Else
      Begin
        tipoCampo := ftFloat;
        tamanhoCampo := 0;
      End;

      If xmlRegistro.Attributes['rs:nullable'] = null Then
        requerido := False
      Else
        requerido := Not xmlRegistro.Attributes['rs:nullable'];

      Result.FieldDefs.Add(nomeCampo, tipoCampo, tamanhoCampo, requerido);

      xmlRegistro := xmlRegistro.NextSibling;
    End;

    Result.CreateDataSet;
  Finally
    FreeAndNil(xmlGen);
  End;
end;

end.
