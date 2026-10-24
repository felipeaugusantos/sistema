unit untFatContratoEmpreitaHelper;

interface

uses SysUtils, Classes, untFatContratoEmpreitaIntf, Forms, Windows, Uni;

type
  TContratoEmpreitaHelper = Class
  private
  public
    class function fPreencheDadosEmpresa(strCodEmp: String): IDadosEmpresa;
    class function fExisteArqModContratoEmpreita: Boolean;

    class function fGeraContratoEmpreita(objContratoEmp: IContratoEmpreita;
      Owner: TComponent): Boolean;
  end;

CONST
  strNomDir = 'CONTRATO DE EMPREITA';
  strNomArqMod = '\MODELO_CONTRATO_EMPREITA.DOC';

implementation

uses untFuncoesSimples, untValorPorExtenso, untFuncoesGenerica, untWord, untFactoryClass,
    Data.DB;

{ TContratoEmpreitaHelper }

class function TContratoEmpreitaHelper.fExisteArqModContratoEmpreita: Boolean;
begin
  Result := FileExists(pChar(ExtractFilePath(Application.ExeName) + strNomArqMod));
end;

class function TContratoEmpreitaHelper.fGeraContratoEmpreita(objContratoEmp: IContratoEmpreita;
  Owner: TComponent): Boolean;
  Var
    Word: TWord;
    strArqDes,
    strArqOri,
    strData,
    strDataExt: String;
    intLinha: Integer;
    fltTotVal: Double;
begin
  fltTotVal := 0.0;

  Result := False;
  
  Try
    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + strNomDir) Then
      CreateDir(ExtractFilePath(Application.ExeName) + strNomDir);

    strArqOri := ExtractFilePath(Application.ExeName) + strNomArqMod;

    strArqDes := ExtractFilePath(Application.ExeName) + strNomDir + '\CONTRATO_EMPREITA_' +
                 FormatDateTime('yyyymmdd', VS_Date) + '-' + objContratoEmp.NumeroContrato + '.DOC';

    If FileExists(pChar(strArqDes)) Then
      DeleteFile(pChar(strArqDes));

    CopyFile(pChar(strArqOri), pChar(strArqDes), False);

    Word := TWord.fCriarWord(Owner);

    If Word = Nil Then
      Exit;

    If Not Word.AbrirArquivo(strArqDes) Then
    Begin
      fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
      Exit;
    End;

    strData    := '31/12/' + FormatDateTime('yyyy', VS_Date);
    strDataExt := ' ' + fRetDataExtenso(VS_Date);

    Word.pGoToPageHeader;
    Word.pGoToMainDocument;

    Word.pReplace('{{NFS}}'    , objContratoEmp.NumeroContrato);
    Word.pReplace('{{NOMCLI}}' , AnsiUpperCase(objContratoEmp.DadosCliente.Nome));
    Word.pReplace('{{FONCLI}}' , fFormataFone(objContratoEmp.DadosCliente.Fone));
    Word.pReplace('{{FAXCLI}}' , fFormataFone(objContratoEmp.DadosCliente.Fax));
    Word.pReplace('{{ENDCLI}}' , objContratoEmp.DadosCliente.Endereco);
    Word.pReplace('{{EMLCLI}}' , objContratoEmp.DadosCliente.Email);
    Word.pReplace('{{CIDCLI}}' , objContratoEmp.DadosCliente.Municipio);
    Word.pReplace('{{ESTCLI}}' , objContratoEmp.DadosCliente.Estado);
    Word.pReplace('{{CEPCLI}}' , fFormataCEP(objContratoEmp.DadosCliente.Cep));
    Word.pReplace('{{CPFCLI}}' , fFormataCpfCgc(objContratoEmp.DadosCliente.CnpjCpf, fSetaPais));
    Word.pReplace('{{IECLI}}'  , objContratoEmp.DadosCliente.IE);

    Word.pReplace('{{NOMEMP}}' , AnsiUpperCase(objContratoEmp.DadosEmpresa.Nome));
    Word.pReplace('{{CNPJEMP}}', fFormataCpfCgc(objContratoEmp.DadosEmpresa.Cnpj, fSetaPais));
    Word.pReplace('{{IEEMP}}'  , objContratoEmp.DadosEmpresa.IE);
    Word.pReplace('{{CIDEMP}}' , objContratoEmp.DadosEmpresa.Municipio + '-' + objContratoEmp.DadosEmpresa.Estado);
    Word.pReplace('{{ENDEMP}}' , objContratoEmp.DadosEmpresa.Endereco);
    Word.pReplace('{{CEPEMP}}' , objContratoEmp.DadosEmpresa.Cep);
    Word.pReplace('{{ENDOBR}}' , objContratoEmp.LocalObra.Endereco);
    Word.pReplace('{{BAIOBR}}' , objContratoEmp.LocalObra.Bairro);
    Word.pReplace('{{CIDOBR}}' , objContratoEmp.LocalObra.Municipio);
    Word.pReplace('{{NATOBR}}' , objContratoEmp.LocalObra.NaturezaObra);
    Word.pReplace('{{ESTOBR}}' , objContratoEmp.LocalObra.Estado);
    Word.pReplace('{{CEPOBR}}' , fFormataCEP(objContratoEmp.LocalObra.Cep));
    Word.pReplace('{{DTAPRZ}}' , strData);
    Word.pReplace('{{DTAEXT}}' , strDataExt);

    {*******************************************************}
    {* GERA CABEÇALHO DA TABELA QUE FICARÁ OS ITENS DA NFS *}
    {*****************************************************FC}
    Word.pCriaTabela('{{ITENS}}', objContratoEmp.ItensContrato.Count+3, 3);
    intLinha := 1;

    Word.pCelulaNegrito(intLinha, 1);
    Word.pCelulaAlignRight(intLinha, 1);
    Word.pCelulaEscreve(intLinha, 1, 'VOLUME');

    Word.pCelulaNegrito(intLinha, 2);
    Word.pCelulaEscreve(intLinha, 2, 'DESCRIÇÃO');

    Word.pCelulaNegrito(intLinha, 3);
    Word.pCelulaAlignRight(intLinha, 3);
    Word.pCelulaEscreve(intLinha, 3, 'VALOR/M3');

    Inc(intLinha);

    {******************************}
    {* ESCREVE OS ITENS NA TABELA *}
    {****************************FC}
    If objContratoEmp.ItensContrato <> nil Then
    Begin
      objContratoEmp.ItensContrato.Iterator.Reset;
      While objContratoEmp.ItensContrato.Iterator.Next Do
      Begin
        Word.pCelulaAlignRight(intLinha, 1);
        Word.pCelulaEscreve(intLinha, 1, FormatFloat(',0.00', (objContratoEmp.ItensContrato.Iterator.CurrentItem as IItensContrato).Volume));

        Word.pCelulaEscreve(intLinha, 2, (objContratoEmp.ItensContrato.Iterator.CurrentItem as IItensContrato).DescricaoItem);

        Word.pCelulaAlignRight(intLinha, 3);
        Word.pCelulaEscreve(intLinha, 3, FloatToStrF((objContratoEmp.ItensContrato.Iterator.CurrentItem as IItensContrato).Valor, ffCurrency, 12, 2));

        fltTotVal := fltTotVal + (objContratoEmp.ItensContrato.Iterator.CurrentItem as IItensContrato).Valor;
        
        Inc(intLinha);
      End;
    End;

    Inc(intLinha);
    Word.pCelulaNegrito(intLinha, 2);
    Word.pCelulaAlignRight(intLinha, 2);
    Word.pCelulaEscreve(intLinha, 2, 'TOTAL: ');

    Word.pCelulaNegrito(intLinha, 3);
    Word.pCelulaAlignRight(intLinha, 3);
    Word.pCelulaEscreve(intLinha, 3, FloatToStrF(fltTotVal, ffCurrency, 12, 2));

    Word.pSalvar;
    FreeAndNil(Word);
    pExecArquivo(strArqDes, 0);

    Result := True;
  Except
    fMensagem('', 'Erro ao gerar o arquivo Word!', ['&Ok']);
  End;
end;

class function TContratoEmpreitaHelper.fPreencheDadosEmpresa(strCodEmp: String): IDadosEmpresa;
  Var
    qryEmp: TUniQuery;
    strSQL: String;
    objDadosEmpresa: IDadosEmpresa;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE';
  strSQL := strSQL + '   EMP_NOMEMP, ';
  strSQL := strSQL + '   EMP_C_G_C_, ';
  strSQL := strSQL + '   EMP_I_E_S_, ';
  strSQL := strSQL + '   CID_NOMCID, ';
  strSQL := strSQL + '   CID_ESTADO, ';
  strSQL := strSQL + '   CONCAT(COALESCE(EMP_ENDERE, ""), ", ", COALESCE(EMP_ENDNUM, ""), " ", COALESCE(EMP_ENDCMP, "")) AS EMP_ENDERE, ';
  strSQL := strSQL + '   EMP_C_E_P_ ';
  strSQL := strSQL + ' FROM CADEMP ';
  strSQL := strSQL + '   INNER JOIN CADCID ON (CID_CODCID = EMP_CODCID) ';
  strSQL := strSQL + ' WHERE EMP_CODEMP = :CODEMP';

  qryEmp := fCriaQuery;

  With qryEmp Do
  Begin
    SQL.Text := strSQL;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    If Not IsEmpty Then
    Begin
      objDadosEmpresa           := Factory.Create('DadosEmpresa') as IDadosEmpresa;
      objDadosEmpresa.Nome      := FieldByName('EMP_NOMEMP').AsString;
      objDadosEmpresa.Cnpj      := FieldByName('EMP_C_G_C_').AsString;
      objDadosEmpresa.IE        := FieldByName('EMP_I_E_S_').AsString;
      objDadosEmpresa.Municipio := FieldByName('CID_NOMCID').AsString;
      objDadosEmpresa.Endereco  := FieldByName('EMP_ENDERE').AsString;
      objDadosEmpresa.Cep       := FieldByName('EMP_C_E_P_').AsString;
      objDadosEmpresa.Estado    := FieldByName('CID_ESTADO').AsString;
    End
    Else
      objDadosEmpresa := nil;
  End;

  Result := objDadosEmpresa;
end;

end.
