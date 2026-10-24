{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta AdvanceTintoSystem *}
{**********************************************************************PH*}
unit untGravandoExecucaoAdvanceTintoSystemCores;

interface

uses
  untAbstractGravandoExecucaoAdvanceTintoSystem, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoAdvanceTintoSystemCores = class(TAbstractGravandoExecucaoAdvanceTintoSystem)
  private
    procedure LimparTabela;
  public
    function fGetNomeGravacao: string; override;
    function GetPath : String; override;
    function GetAdoQuery(var strNomeArquivo:String):TADOQuery; override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetDataSetDestino(): IDataSet; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: IDataSet); override;
    procedure Executar(const gravando: IGravando); override;
  end;

Implementation

uses
  untFuncoesGenerica, untStrUtils, untDefinicaoTxtCampoTipo, untADOTxtFactory, untGenericDefinicaoTxtCampo, untGenericDefinicaoTxt,
    untIDefinicaoTxtCampo, untIDefinicaoTxt, untDefinicaoTxtCharacterSet;

{ TGravandoExecucaoAdvanceTintoSystemCores }

procedure TGravandoExecucaoAdvanceTintoSystemCores.Executar(const gravando: IGravando);
Var
  qryOrigem : TDataSet;
  qryDestino: IDataSet;
begin
  Try
    Try
      Gravando.Texto := 'Limpando Cadastro de Fórmulas...';
      LimparTabela;
      Gravando.Texto := 'Cadastro de Fórmulas limpo com sucesso...';

      Gravando.Texto := 'Verificando Path do Arquivo...';

      If Not fValidaPath Then
      Begin
      Gravando.Texto := Format('O path [%s] não está configurado, ou não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
      Exit;
      End;

      If (Gravando.Status <> sgGravando) Then
      Exit;

      Gravando.Texto := 'Path verificado com sucesso...';

      Gravando.Texto := 'Carregando dados do Cadastro de Fórmulas...';

      CarregarDados(Gravando, qryOrigem, GetPath, qryDestino);

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ADT_CADADT');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Dados carregados com sucesso...';

      Gravando.Texto := Format ('Processando Arquivo: [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      qryOrigem.First;

      While Not qryOrigem.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        Try
          Try

            If Not IsRegistroExistente(qryOrigem, qryDestino) Then
              GravarRegistro(qryOrigem, qryDestino);

          Except
            On E: Exception Do
              Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          End;
        Finally
          qryOrigem.Next;
          Gravando.RegistrarProgresso(0, qryOrigem.RecNo, qryOrigem.RecordCount);
        End;
      End;

    Except
      On E: Exception Do
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
    End;
  Finally
    Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Fórmulas']);
  End;


end;

function TGravandoExecucaoAdvanceTintoSystemCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;




function TGravandoExecucaoAdvanceTintoSystemCores.GetAdoQuery(
  var strNomeArquivo: String): TADOQuery;
Var
  Definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';', dtcsDefault, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
    TGenericDefinicaoTxtCampo.Create('IdFormula', dtctText),
    TGenericDefinicaoTxtCampo.Create('Codigo da Cor', dtctText),
    TGenericDefinicaoTxtCampo.Create('Codigo Tecnico', dtctText),
    TGenericDefinicaoTxtCampo.Create('Produto', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdProduto', dtctText),
    TGenericDefinicaoTxtCampo.Create('Base', dtctText),
    TGenericDefinicaoTxtCampo.Create('Cod Base', dtctText),
    TGenericDefinicaoTxtCampo.Create('Id_Base', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdProdBas', dtctText),
    TGenericDefinicaoTxtCampo.Create('Embalagem', dtctText),
    TGenericDefinicaoTxtCampo.Create('Conteudo', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('IdEmb', dtctText),
    TGenericDefinicaoTxtCampo.Create('Preco Base', dtctCurrency),
    TGenericDefinicaoTxtCampo.Create('IdCoran1', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran2', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran3', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran4', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran5', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran6', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran7', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran8', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran9', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran10', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran11', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran12', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran13', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran14', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran15', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran16', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCoran17', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran1', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran2', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran3', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran4', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran5', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran6', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran7', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran8', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran9', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran10', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran11', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran12', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran13', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran14', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran15', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran16', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCoran17', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante1', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante2', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante3', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante4', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante5', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante6', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante7', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante8', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante9', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante10', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante11', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante12', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante13', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante14', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante15', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante16', dtctText),
    TGenericDefinicaoTxtCampo.Create('Desc_Corante17', dtctText),
    TGenericDefinicaoTxtCampo.Create('ML_Corante1', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante2', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante3', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante4', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante5', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante6', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante7', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante8', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante9', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante10', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante11', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante12', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante13', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante14', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante15', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante16', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_Corante17', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('ML_TotalCor', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('Preco_Cor', dtctCurrency),
    TGenericDefinicaoTxtCampo.Create('Catalisador', dtctText),
    TGenericDefinicaoTxtCampo.Create('CodCatalis', dtctText),
    TGenericDefinicaoTxtCampo.Create('IdCatalis', dtctText),
    TGenericDefinicaoTxtCampo.Create('Volume Catal', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('Preco Catal', dtctCurrency),
    TGenericDefinicaoTxtCampo.Create('Volume Final', dtctDouble),
    TGenericDefinicaoTxtCampo.Create('Preco', dtctCurrency),
    TGenericDefinicaoTxtCampo.Create('Data', dtctDate)]));

  TADOTxtFactory.Registrar(Definicao);
  strNomeArquivo := Definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

function TGravandoExecucaoAdvanceTintoSystemCores.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
end;

function TGravandoExecucaoAdvanceTintoSystemCores.GetPath: String;
begin
  Result := Conf.fGet('PATADT') + '\Integracao.csv';
end;

function TGravandoExecucaoAdvanceTintoSystemCores.GetSqlDestino: string;
begin
  Result := TAutcomTintaFactory.Get.GetInsert('ADT_CADADT');
end;

function TGravandoExecucaoAdvanceTintoSystemCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '   SELECT                ' +
            '     I.*                 ' +
            '   FROM                  ' +
            '     INTEGRACAO#CSV AS I ' +
            '   ORDER BY I.IDFORMULA  ' ;
end;

procedure TGravandoExecucaoAdvanceTintoSystemCores.GravarRegistro(
  const qryOrigem: TDataSet; const qryDestino: IDataSet);
Var
  intFormula,
  intContador: Integer;
begin

  qryDestino.SQL := GetSqlDestino;

  qryDestino.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADT_CADADT', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.ParamByName('ADT_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.ParamByName('ADT_IDFORM').AsString := TStrUtils.fStrZero(LimpaTexto(qryOrigem.FieldByName('IdFormula').AsString), 4);
  qryDestino.ParamByName('ADT_CODCOR').AsString := LimpaTexto(qryOrigem.FieldByName('Codigo da Cor').AsString);
  qryDestino.ParamByName('ADT_CODTEC').AsString := LimpaTexto(qryOrigem.FieldByName('Codigo Tecnico').AsString);
  qryDestino.ParamByName('ADT_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('Produto').AsString);
  qryDestino.ParamByName('ADT_CODBAS').AsString := LimpaTexto(qryOrigem.FieldByName('Cod Base').AsString);
  qryDestino.ParamByName('ADT_CODEMB').AsString := TStrUtils.fStrZero(LimpaTexto(qryOrigem.FieldByName('IdEmb').AsString), 3);

  intFormula := 1;
  For intContador := 1 To 17 Do
  Begin
    If qryOrigem.FieldByName('ML_Corante' + IntToStr(intContador)).AsFloat > 0 Then
    Begin

      qryDestino.ParamByName('ADT_CODC' + TStrUtils.fStrZero(intFormula, 2)).AsString :=
        qryOrigem.FieldByName('CodCoran' + IntToStr(intContador)).AsString;


      qryDestino.ParamByName('ADT_QTDC' + TStrUtils.fStrZero(intFormula, 2)).AsFloat  :=
        qryOrigem.FieldByName('ML_Corante' + intToStr(intContador)).AsFloat;

      Inc(intFormula);
    End;
  End;

  qryDestino.ParamByName('ADT_CODCAT').AsString := LimpaTexto(qryOrigem.FieldByName('CodCatalis').AsString);
  qryDestino.ParamByName('ADT_QTDBAS').AsFloat  := qryOrigem.FieldByName('Conteudo').AsFloat;
  qryDestino.ParamByName('ADT_QTD_ML').AsFloat  := qryOrigem.FieldByName('ML_TotalCor').AsFloat;
  qryDestino.ParamByName('ADT_QTDCAT').AsFloat  := qryOrigem.FieldByName('Volume Catal').AsFloat;
  qryDestino.ParamByName('ADT_QTDFIN').AsFloat  := qryOrigem.FieldByName('Volume Final').AsFloat;

  qryDestino.ParamByName('ADT_MD5KEY').AsString := GetMD5(qryDestino.ParamBynAME('ADT_IDFORM').AsString +
                                                          qryDestino.ParamByName('ADT_CODCOR').AsString +
                                                          qryDestino.ParamByName('ADT_CODTEC').AsString +
                                                          qryDestino.ParamByName('ADT_PRODUT').AsString +
                                                          qryDestino.ParamByName('ADT_CODBAS').AsString +
                                                          qryDestino.ParamByName('ADT_CODEMB').AsString +
                                                          qryDestino.ParamByName('ADT_CODCAT').AsString);

  qryDestino.ExecSQL;

end;

function TGravandoExecucaoAdvanceTintoSystemCores.IsRegistroExistente(
  const qryOrigem: TDataSet; const qryDestino: IDataSet): Boolean;
begin
  Result := False;
end;

procedure TGravandoExecucaoAdvanceTintoSystemCores.LimparTabela;
Var
  qryTruncate: IDataSet;
Begin
  Try
    qryTruncate := TAutcomTintaFactory.Get.fGetDataSet;
    qryTruncate.SQL := '    TRUNCATE TABLE ADT_CADADT   ';
    qryTruncate.ExecSQL;
  Except
    Raise;
  End;
End;

end.
