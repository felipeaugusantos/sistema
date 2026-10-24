{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Dupont  *}
{**********************************************************************AC*}
unit untGravandoExecucaoDupontCores;

interface

uses
  untAbstractGravandoExecucaoDupont, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela,
  StrUtils, untTipoCadastro, untFloatUtils, Classes, XMLDoc, XMLIntf, Variants,
  UniClientDataSet, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

Type
  TBaseDup = Record
    strCodBas: String;
    strTipBas: String; // Tipo: (B)ase (C)atalizado (D)iluente
    fltQtdCon: Double;
    fltQtdDil: Double;
  End;

type
  TGravandoExecucaoDupontCores = class(TAbstractGravandoExecucaoDupont)
  private
    qryInsert: TFDQuery;

    function fCriaQueryCores(): String;
    procedure AjustarQuantidadesDiluidasNB(const Gravando: IGravando);

    function fXmlCompQualidadeToDataSet(const gravando: IGravando): TUniClientDataSet;
    function fXmlPadraoRelMistQldToDataSet(const gravando: IGravando): TUniClientDataSet;
    function fXmlLitrografiaToDataSet(const gravando: IGravando): TUniClientDataSet;
    function fXmlObservacaoToDataSet(const gravando: IGravando): TUniClientDataSet;
    function fXmlProcurarValor(xmlNoPai: IXMLNode; strAtributo: String; valor: String): IXMLNode;
    function fXmlToDataSet(strArquivo: String; const gravando: IGravando): TUniClientDataSet;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

  TBaseDupArray = Array Of TBaseDup;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoDupontCores }

procedure TGravandoExecucaoDupontCores.AjustarQuantidadesDiluidasNB(const Gravando: IGravando);
Var
  qryCor: IDataSet;
  intContador: Integer;
begin
  qryCor := TAutcomTintaFactory.Get.fGetDataSet;
  qryCor.SQL := ' SELECT * FROM DUP_CADDUP WHERE DUP_QUALID = "NB"    ';
  qryCor.Open;

  Gravando.Texto := 'Ajustando Quantidades da Qualidade NB...';

  While Not qryCor.Eof Do
  Begin
    For intContador := 1 To 20 Do
    Begin
      If TStrUtils.fEmptyStr(qryCor.FieldByName('DUP_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      qryCor.Edit;
      qryCor.FieldByName('DUP_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCor.FieldByName('DUP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
      qryCor.FieldByName('DUP_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 0.0000;
      qryCor.Post;
    End;

    qryCor.Next;
    Gravando.RegistrarProgresso(0, qryCor.RecNo, qryCor.RecordCount);
  End;
end;

procedure TGravandoExecucaoDupontCores.Executar(const gravando: IGravando);
var
    strPat: String;
    xmlFormulas: TXMLDocument;
    xmlCP: TXMLDocument;

    xmlRegistro: IXMLNode;
    xmlRegistroCP: IXMLNode;

    cdsCompQualidade: TUniClientDataSet;
    cdsRelMistura: TUniClientDataSet;
    cdsLitrografia: TUniClientDataSet;
    cdsObservacao: TUniClientDataSet;
    cdsArqCp: TUniClientDataSet;

    intNumArq: Integer;
    strIdFormula: String;
    blnSomenteConc: Boolean;
    strLinhaCor: String;
    strQualidade: String;

    strCatalisador: String;
    fltPesEspCatal: Double;
    fltRelacCatal: Double;

    strDiluente: String;
    fltPesEspDilul: Double;
    fltRelacDilul: Double;

    fltPartesTinta: Double;
    fltTotalPartes: Double;

    fltFatorRelacao: Double;
    fltPesoTeorico: Double;

    fltPeso1: Double;

    arrBases: TBaseDupArray;

    intCont: Integer;
    intLinha: Integer;
    intAutoInc: Integer;
    intPos: Integer;
    intMaximo: Integer;

    AComp: TComponent;
    strMd5Anterior: String;

    stlObs: TStringList;
    intObs: Integer;
    strObservacao: string;
    strObsAnterior: string;
    strObsCV: string;

    intQtdsF: Integer;

    procedure limpar;
    Begin
      If Assigned(xmlFormulas) Then FreeAndNil(xmlFormulas);
      If Assigned(xmlCP) Then FreeAndNil(xmlCP);
      If Assigned(cdsCompQualidade) Then FreeAndNil(cdsCompQualidade);
      If Assigned(cdsRelMistura) Then FreeAndNil(cdsRelMistura);
      If Assigned(cdsLitrografia) Then FreeAndNil(cdsLitrografia);
      If Assigned(cdsObservacao) Then FreeAndNil(cdsObservacao);
      If Assigned(cdsArqCp) Then FreeAndNil(cdsArqCp);
      If Assigned(stlObs) Then FreeAndNil(stlObs);
      If Assigned(qryInsert) Then FreeAndNil(qryInsert);
    End;

begin
  intLinha := 1;
  strPat   := conf.fGet('PATDUP');
  strMd5Anterior := '';

  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath(ttGeral, 1)) Then
      Begin
        gravando.Texto := Format('O arquivo %s não existe', [GetPath(ttGeral, 1)]);
        gravando.Cancelar;
        Exit;
      End;

      If (Not fValidaPath(ttGeral, 2)) Then
      Begin
        gravando.Texto := Format('O arquivo %s não existe', [GetPath(ttGeral, 2)]);
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('DUP_CADDUP');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      //Criando a tabela de insert
      qryInsert := TFDQuery.Create(Nil);
      qryInsert.Connection := FDDatabase;
      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(fCriaQueryCores);

      gravando.Texto := 'Limpando a Tabela de Cores ...';

      gravando.Texto := 'Limpando DUP_CADDUP...';
      TAutcomTintaFactory.Get.TruncateTable('DUP_CADDUP');
      gravando.Texto := 'DUP_CADDUP limpa com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      AComp := TComponentClass.Create(nil);

      xmlFormulas := TXMLDocument.Create(AComp);
      xmlFormulas.FileName := GetPath(ttGeral, 1);
      xmlFormulas.Active := True;

      gravando.Texto := 'Carregando arquivo de fórmulas, isso pode demorar alguns minutos...';
      xmlRegistro := xmlFormulas.ChildNodes.FindNode('xml');
      xmlRegistro := xmlRegistro.ChildNodes.FindNode('data');
      xmlRegistro := xmlRegistro.ChildNodes.First;
      gravando.Texto := 'Arquivo de fórmulas carregado com sucesso!';

      cdsCompQualidade := fXmlCompQualidadeToDataSet(gravando);
      cdsRelMistura    := fXmlPadraoRelMistQldToDataSet(gravando);
      cdsLitrografia   := fXmlLitrografiaToDataSet(gravando);
      cdsObservacao    := fXmlObservacaoToDataSet(gravando);

      If Not Assigned(xmlRegistro) Then
      Begin
        gravando.Texto := Format('O arquivo %s não está no formato esperado', [GetPath(ttGeral, 1)]);
        gravando.Cancelar;
        limpar;
        Exit;
      End;

      if gravando.Status <> sgGravando then
        Exit;

      xmlCP := TXMLDocument.Create(AComp);

      stlObs := TStringList.Create;

      intPos := 1;
      gravando.Texto := 'Cadastrando tintas...';
      intMaximo := xmlRegistro.ParentNode.ChildNodes.Count;
      While Assigned(xmlRegistro) Do
      Begin
        if gravando.Status <> sgGravando then
          Exit;

        strLinhaCor  := xmlRegistro.Attributes['LP'];
        strQualidade := xmlRegistro.Attributes['DQ'];
        strIdFormula := xmlRegistro.Attributes['ID'];

        SetLength(arrBases, 0);

        intNumArq := (StrToIntDef(strIdFormula, 0) div 90) + 1;
        If ((StrToIntDef(strIdFormula, 0) mod 90) = 0) Then
          intNumArq := intNumArq - 1;

        If Not FileExists(strPat + '\cp' + IntToStr(intNumArq) + '.xml') Then
        Begin
          gravando.RegistrarProgresso(0, intPos, intMaximo);
          intPos := intPos + 1;
          xmlRegistro := xmlRegistro.NextSibling;
          Continue;
        End;

        xmlCP.Active := False;
        xmlCP.FileName := strPat + '\cp' + IntToStr(intNumArq) + '.xml';
        xmlCP.Active := True;

        xmlRegistroCP := xmlCP.ChildNodes.FindNode('xml').ChildNodes.FindNode('data').ChildNodes.First;
        xmlRegistroCP := fXmlProcurarValor(xmlRegistroCP, 'I', strIdFormula);

        If Not Assigned(xmlRegistroCP) Then
        Begin
          gravando.RegistrarProgresso(0, intPos, intMaximo);
          intPos := intPos + 1;
          xmlRegistro := xmlRegistro.NextSibling;
          Continue;
        End;

        If Not cdsLitrografia.Locate('LINHA_PRODUTO;QUALIDADE',
          VarArrayOf([strLinhaCor, strQualidade]), []) Then
        Begin
          gravando.Texto := Format('Não foi possivel encontrar a litografia da Linha: [%s], Qualidade: [%s] no arquivo litografia.xml', [strLinhaCor, strQualidade]);
          gravando.RegistrarProgresso(0, intPos, intMaximo);
          intPos := intPos + 1;
          xmlRegistro := xmlRegistro.NextSibling;
          Continue;
        End;

        blnSomenteConc := Not cdsRelMistura.Locate('LINHA_PRODUTO;DSCR_QUALIDADE', VarArrayOf([strLinhaCor, strQualidade]), []);

        strCatalisador   := '';
        fltPesEspCatal   := 0.0;
        fltRelacCatal    := 0.0;

        strDiluente      := '';
        fltPesEspDilul   := 0.0;
        fltRelacDilul    := 0.0;

        fltPartesTinta := cdsRelMistura.FieldByName('RELACAO').AsFloat;
        fltTotalPartes := cdsRelMistura.FieldByName('RELACAO').AsFloat;

        While (Not cdsRelMistura.Eof)
          And (Not blnSomenteConc)
          And (cdsRelMistura.FieldByName('LINHA_PRODUTO').AsString = strLinhaCor)
          And (cdsRelMistura.FieldByName('DSCR_QUALIDADE').AsString = strQualidade) Do
        Begin
          fltTotalPartes := fltTotalPartes + cdsRelMistura.FieldByName('VALOR').AsFloat;

          If cdsRelMistura.FieldByName('DSCR_TIPO_COMPONENTE').AsString = 'CATALISADOR' Then
          Begin
            strCatalisador := cdsRelMistura.FieldByName('COD_COMPONENTE_RELACAO').AsString;
            fltRelacCatal := cdsRelMistura.FieldByName('VALOR').AsFloat * 100;
          End
          Else
          Begin
            strDiluente := cdsRelMistura.FieldByName('COD_COMPONENTE_RELACAO').AsString;
            fltRelacDilul := cdsRelMistura.FieldByName('VALOR').AsFloat * 100;
          End;

          cdsRelMistura.Next;
        End;

        If Not TStrUtils.fEmptyStr(strCatalisador) Then
        Begin
          cdsCompQualidade.Locate('VCOMPONENTE;VLINHA_PRODUTO;VQUALIDADE',
            VarArrayOf([strCatalisador, strLinhaCor, strQualidade]), []);

          fltPesEspCatal := cdsCompQualidade.FieldByName('VPESO').AsFloat * 100;
        End;

        If Not TStrUtils.fEmptyStr(strDiluente) Then
        Begin
          cdsCompQualidade.Locate('VCOMPONENTE;VLINHA_PRODUTO;VQUALIDADE',
            VarArrayOf([strDiluente, strLinhaCor, strQualidade]), []);

          fltPesEspDilul := cdsCompQualidade.FieldByName('VPESO').AsFloat * 100;
        End;

        strObservacao  := '';
        strObsAnterior := '';

        While Assigned(xmlRegistroCP) Do
        Begin
          //Monta string observacao
          stlObs.Clear;

          strObsCV := '';
          If (xmlRegistroCP.Attributes['CV'] <> Null) Then
            strObsCV := xmlRegistroCP.Attributes['CV'];

          If Not TStrUtils.fEmptyStr(strObsCV) Then
          Begin
            stlObs.CommaText := AnsiReplaceStr(strObsCV, ';', ',');

            //podem ter duas ou mais observacoes na mesma base
            For intObs := 0 To stlObs.Count - 1 Do
            Begin

              //Verifica se essa observacao ja foi incluida
              If Pos (stlObs[intObs], strObsAnterior) <= 0 Then
              Begin
                strObsAnterior := strObsAnterior + stlObs[intObs] + '_';

                If cdsObservacao.Locate('C', stlObs[intObs], []) Then
                Begin
                  If TStrUtils.fEmptyStr(strObservacao) Then
                    strObservacao := cdsObservacao.FieldByName('P').AsString
                  Else
                    strObservacao := strObservacao + '/' + cdsObservacao.FieldByName('P').AsString;
                End;
              End;
            End;
          End;

          If (xmlRegistroCP.Attributes['PP'] <> Null) And (fFormataFloatDupont(xmlRegistroCP.Attributes['PP']) > 0) Then
            fltPesoTeorico := fFormataFloatDupont(xmlRegistroCP.Attributes['PP'])
          Else
            fltPesoTeorico := fFormataFloatDupont(xmlRegistroCP.Attributes['PT']);

          fltPesoTeorico := fltPesoTeorico;

          fltPeso1 := (((fFormataFloatDupont(xmlRegistroCP.Attributes['PC']) * 100) / 100) * 100) / (100 / fltPesoTeorico);

          SetLength(arrBases, Length(arrBases) + 1);
          arrBases[Length(arrBases) - 1].strCodBas :=  xmlRegistroCP.Attributes['CC']; //cdsArqCp.FieldByName('CC').AsString;
          arrBases[Length(arrBases) - 1].strTipBas := 'B';
          arrBases[Length(arrBases) - 1].fltQtdCon := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;

          arrBases[Length(arrBases) - 1].fltQtdDil := 0.0;

          If (Not blnSomenteConc) Then
            arrBases[Length(arrBases) - 1].fltQtdDil := (fFormataFloatDupont(xmlRegistroCP.Attributes['PC']) * fltPesoTeorico) *
              (fltPartesTinta / fltTotalPartes) *
              (cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100);

          xmlRegistroCP := fXmlProcurarValor(xmlRegistroCP.NextSibling, 'I', strIdFormula);
        End;

        If (Not TStrUtils.fEmptyStr(strCatalisador)) Then
        Begin
          fltPeso1 := (fltRelacCatal / fltTotalPartes) * (fltPesEspCatal / 100);

          SetLength(arrBases, Length(arrBases) + 1);
          arrBases[Length(arrBases) - 1].strCodBas := strCatalisador;
          arrBases[Length(arrBases) - 1].strTipBas := 'C';
          arrBases[Length(arrBases) - 1].fltQtdCon := 0.0;
          arrBases[Length(arrBases) - 1].fltQtdDil := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;
        End;

        If (Not TStrUtils.fEmptyStr(strDiluente)) Then
        Begin
          fltPeso1 := (fltRelacDilul / fltTotalPartes) * (fltPesEspDilul / 100);

          SetLength(arrBases, Length(arrBases) + 1);
          arrBases[Length(arrBases) - 1].strCodBas := strDiluente;
          arrBases[Length(arrBases) - 1].strTipBas := 'D';
          arrBases[Length(arrBases) - 1].fltQtdCon := 0.0;
          arrBases[Length(arrBases) - 1].fltQtdDil := fltPeso1 * cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat / 100;
        End;

        if gravando.Status <> sgGravando then
          Exit;

        qryInsert.Params.ClearValues();
        qryInsert.Params.ArraySize := 1;


        qryInsert.ParamByName('DUP_CODSEQ').AsStrings[0]    := TStrUtils.fStrZero(intLinha, 6);
        qryInsert.ParamByName('DUP_CODDUP').AsStrings[0]    := VarToStr(xmlRegistro.Attributes['C']);
        qryInsert.ParamByName('DUP_CODOEM').AsStrings[0]    := VarToStr(xmlRegistro.Attributes['P']);
        qryInsert.ParamByName('DUP_LINHA_').AsStrings[0]    := strLinhaCor;
        qryInsert.ParamByName('DUP_QUALID').AsStrings[0]    := strQualidade;
        qryInsert.ParamByName('DUP_ALTERN').AsStrings[0]    := TAutcomTintaFactory.Get.IIF(xmlRegistro.Attributes['A'] = Null, '', VarToStr(xmlRegistro.Attributes['A']));
        qryInsert.ParamByName('DUP_REGIAO').AsStrings[0]    := TAutcomTintaFactory.Get.IIF(xmlRegistro.Attributes['DP'] = Null, '', VarToStr(xmlRegistro.Attributes['DP']));
        qryInsert.ParamByName('DUP_DESCRI').AsStrings[0]    := VarToStr(xmlRegistro.Attributes['D']);
        qryInsert.ParamByName('DUP_MONTAD').AsStrings[0]    := TAutcomTintaFactory.Get.IIF(xmlRegistro.Attributes['DM'] = Null, '', VarToStr(xmlRegistro.Attributes['DM']));
        qryInsert.ParamByName('DUP_ANOCOR').AsStrings[0]    := VarToStr(xmlRegistro.Attributes['AN']);
        qryInsert.ParamByName('DUP_CODEMP').AsStrings[0] := TAutcomTintaFactory.Get.GetCodEmp;
        qryInsert.ParamByName('AUTOINCREM').AsStrings[0] := TAutcomTintaFactory.Get.fRetAutoIncrem('DUP_CADDUP', TAutcomTintaFactory.Get.GetCodEmp);
        qryInsert.ParamByName('DUP_LITRAG').AsFloats[0]  := cdsLitrografia.FieldByName('VOLUME_ENCHIMENTO').AsFloat;
        qryInsert.ParamByName('DUP_OBSERV').AsStrings[0]   := strObservacao;

        For intCont := Low(arrBases) To High(arrBases) Do
        Begin
          qryInsert.ParamByName('DUP_BASE' + TStrUtils.fStrZero(intCont + 1, 2)).AsStrings[0] := arrBases[intCont].strCodBas;
          qryInsert.ParamByName('DUP_QTDC' + TStrUtils.fStrZero(intCont + 1, 2)).AsFloats[0] := arrBases[intCont].fltQtdCon;
          qryInsert.ParamByName('DUP_QTDD' + TStrUtils.fStrZero(intCont + 1, 2)).AsFloats[0]  := arrBases[intCont].fltQtdDil;
          qryInsert.ParamByName('DUP_TIPB' + TStrUtils.fStrZero(intCont + 1, 2)).AsStrings[0] := arrBases[intCont].strTipBas;
        End;

        intQtdsF := High(arrBases) + 1;

        For intCont := intQtdsF To 19 Do
        Begin
          qryInsert.ParamByName('DUP_BASE' + TStrUtils.fStrZero(intCont + 1, 2)).AsStrings[0] := '';
          qryInsert.ParamByName('DUP_QTDC' + TStrUtils.fStrZero(intCont + 1, 2)).AsFloats[0] := 0.0;
          qryInsert.ParamByName('DUP_QTDD' + TStrUtils.fStrZero(intCont + 1, 2)).AsFloats[0]  := 0.0;
          qryInsert.ParamByName('DUP_TIPB' + TStrUtils.fStrZero(intCont + 1, 2)).AsStrings[0] := '';
        End;

        qryInsert.ParamByName('DUP_MD5KEY').AsString := GetMD5(qryInsert.ParamByName('DUP_CODDUP').AsStrings[0] + qryInsert.ParamByName('DUP_CODOEM').AsStrings[0] +
                                                               qryInsert.ParamByName('DUP_LINHA_').AsStrings[0] + qryInsert.ParamByName('DUP_QUALID').AsStrings[0] +
                                                               qryInsert.ParamByName('DUP_ALTERN').AsStrings[0] + qryInsert.ParamByName('DUP_REGIAO').AsStrings[0] +
                                                               qryInsert.ParamByName('DUP_DESCRI').AsStrings[0] + qryInsert.ParamByName('DUP_MONTAD').AsStrings[0] +
                                                               qryInsert.ParamByName('DUP_ANOCOR').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE01').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC01').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD01').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB01').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE02').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC02').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD02').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB02').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE03').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC03').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD03').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB03').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE04').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC04').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD04').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB04').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE05').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC05').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD05').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB05').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE06').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC06').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD06').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB06').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE07').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC07').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD07').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB07').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE08').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC08').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD08').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB08').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE09').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC09').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD09').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB09').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE10').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC10').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD10').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB10').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE11').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC11').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD11').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB11').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE12').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC12').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD12').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB12').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE13').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC13').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD13').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB13').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE14').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC14').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD14').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB14').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE15').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC15').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD15').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB15').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE16').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC16').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD16').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB16').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE17').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC17').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD17').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB17').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE18').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC18').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD18').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB18').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE19').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC19').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD19').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB19').AsStrings[0] +
                                          qryInsert.ParamByName('DUP_BASE20').AsStrings[0] + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDC20').AsFloats[0]), ',', '.') + AnsiReplaceStr(FormatFloat('0.00000', qryInsert.ParamByName('DUP_QTDD20').AsFloats[0]), ',', '.') + qryInsert.ParamByName('DUP_TIPB20').AsStrings[0]);

        If strMd5Anterior <> qryInsert.ParamByName('DUP_MD5KEY').AsStrings[0] Then
          qryInsert.Execute(1, 0);

        strMd5Anterior := qryInsert.ParamByName('DUP_MD5KEY').AsStrings[0];

        intLinha   := intLinha + 1;
        intAutoInc := intAutoInc + 1;

        gravando.RegistrarProgresso(0, intPos, intMaximo);
        xmlRegistro := xmlRegistro.NextSibling;
        intPos      := intPos + 1;
      End;

    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    limpar;
  End;

  AjustarQuantidadesDiluidasNB(Gravando);
end;

function TGravandoExecucaoDupontCores.fCriaQueryCores(): String;
var
  intForm: Integer;
begin
  Result :=             ' INSERT INTO DUP_CADDUP  ' +

                            '           (DUP_CODSEQ,  ' +
                            '            DUP_CODDUP,  ' +
                            '            DUP_CODOEM,  ' +
                            '            DUP_LINHA_,  ' +
                            '            DUP_QUALID,  ' +
                            '            DUP_ALTERN,  ' +
                            '            DUP_REGIAO,  ' +
                            '            DUP_DESCRI,  ' +
                            '            DUP_MONTAD,  ' +
                            '            DUP_ANOCOR,  ' +
                            '            DUP_CODEMP,  ' +
                            '            AUTOINCREM,  ' +
                            '            DUP_LITRAG,  ' +
                            '            DUP_OBSERV,  ';

  For intForm := 1 To 20 Do
  Begin
    Result := Result  + '        DUP_BASE' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        DUP_QTDC' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        DUP_QTDD' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '        DUP_TIPB' + TStrUtils.fStrZero(intForm, 2) + ', ';
  End;

  Result := Result  + '          DUP_MD5KEY)  ' +

                              ' VALUES (:DUP_CODSEQ,  ' +
                              '         :DUP_CODDUP,  ' +
                              '         :DUP_CODOEM,  ' +
                              '         :DUP_LINHA_,  ' +
                              '         :DUP_QUALID,  ' +
                              '         :DUP_ALTERN,  ' +
                              '         :DUP_REGIAO,  ' +
                              '         :DUP_DESCRI,  ' +
                              '         :DUP_MONTAD,  ' +
                              '         :DUP_ANOCOR,  ' +
                              '         :DUP_CODEMP,  ' +
                              '         :AUTOINCREM,  ' +
                              '         :DUP_LITRAG,  ' +
                              '         :DUP_OBSERV,  ';

  For intForm := 1 To 20 Do
  Begin
    Result := Result  + '     :DUP_BASE' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '     :DUP_QTDC' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '     :DUP_QTDD' + TStrUtils.fStrZero(intForm, 2) + ', ' +
                                '     :DUP_TIPB' + TStrUtils.fStrZero(intForm, 2) + ', ';
  End;

  Result := Result  + '       :DUP_MD5KEY); ';
end;

function TGravandoExecucaoDupontCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoDupontCores.fXmlCompQualidadeToDataSet(const gravando: IGravando): TUniClientDataSet;
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
  strPat := strPat + '\compqualidade.xml';

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

    if gravando.Status <> sgGravando then
      Exit;

    xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');
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
      if gravando.Status <> sgGravando then
        Exit;

      Result.Insert;

      Result.FieldByName('VCOMPONENTE').Value    := xmlRegistro.Attributes['VCOMPONENTE'];
      Result.FieldByName('VPESO').AsFloat        := fFormataFloatDupont(xmlRegistro.Attributes['VPESO']);
      Result.FieldByName('VQUALIDADE').Value     := xmlRegistro.Attributes['VQUALIDADE'];
      Result.FieldByName('VTIPO').Value          := xmlRegistro.Attributes['VTIPO'];
      Result.FieldByName('VCODCOMERCIAL').Value  := xmlRegistro.Attributes['VCODCOMERCIAL'];
      Result.FieldByName('VLINHA_PRODUTO').Value := xmlRegistro.Attributes['VLINHA_PRODUTO'];

      Result.Post;

      xmlRegistro := xmlRegistro.NextSibling;
      gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
      intQtdAtual := intQtdAtual + 1;
    End;
  Finally
    FreeAndNil(xmlGen);
  End;
end;

function TGravandoExecucaoDupontCores.fXmlLitrografiaToDataSet(
  const gravando: IGravando): TUniClientDataSet;
  Var
    strPat: String;

    xmlGen: TXMLDocument;
    xmlNoInsert: IXMLNode;
    xmlRegistro: IXMLNode;

    intQtdRegistros: Integer;
    intQtdAtual: Integer;
    AComp: TComponent;
begin
  strPat := Conf.fGet('PATDUP');
  strPat := strPat + '\litografia.xml';

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

    if gravando.Status <> sgGravando then
      Exit;

    xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');
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
      if gravando.Status <> sgGravando then
        Exit;

      Result.Insert;

      Result.FieldByName('LINHA_PRODUTO').Value     := xmlRegistro.Attributes['LINHA_PRODUTO'];
      Result.FieldByName('QUALIDADE').Value         := xmlRegistro.Attributes['QUALIDADE'];
      Result.FieldByName('COD_LITOGRAFIA').Value    := xmlRegistro.Attributes['COD_LITOGRAFIA'];
      Result.FieldByName('DSCR_LITOGRAFIA').Value   := xmlRegistro.Attributes['DSCR_LITOGRAFIA'];
      Result.FieldByName('VOLUME_NOMINAL').Value    := xmlRegistro.Attributes['VOLUME_NOMINAL'];
      Result.FieldByName('VOLUME_MAXIMO').Value     := xmlRegistro.Attributes['VOLUME_MAXIMO'];
      Result.FieldByName('VOLUME_ENCHIMENTO').Value := xmlRegistro.Attributes['VOLUME_ENCHIMENTO'];
      Result.FieldByName('COD_EMB').Value           := xmlRegistro.Attributes['COD_EMB'];
      Result.FieldByName('PADRAO_LINHA').Value      := xmlRegistro.Attributes['PADRAO_LINHA'];
      Result.FieldByName('PADRAO_QUALIDADE').Value  := xmlRegistro.Attributes['PADRAO_QUALIDADE'];

      Result.Post;

      xmlRegistro := xmlRegistro.NextSibling;
      gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
      intQtdAtual := intQtdAtual + 1;
    End;
  Finally
    FreeAndNil(xmlGen);
  End;
end;

function TGravandoExecucaoDupontCores.fXmlObservacaoToDataSet(
  const gravando: IGravando): TUniClientDataSet;
  Var
    strPat: String;

    xmlGen: TXMLDocument;
    xmlNoInsert: IXMLNode;
    xmlRegistro: IXMLNode;

    intQtdRegistros: Integer;
    intQtdAtual: Integer;
    AComp: TComponent;
begin
  strPat := Conf.fGet('PATDUP');
  strPat := strPat + '\cv.xml';

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

    if gravando.Status <> sgGravando then
      Exit;

    xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');
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
      if gravando.Status <> sgGravando then
        Exit;

      Result.Insert;

      Result.FieldByName('C').Value := xmlRegistro.Attributes['C'];
      Result.FieldByName('P').Value := xmlRegistro.Attributes['P'];

      Result.Post;

      xmlRegistro := xmlRegistro.NextSibling;
      gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
      intQtdAtual := intQtdAtual + 1;
    End;
  Finally
    FreeAndNil(xmlGen);
  End;
end;

function TGravandoExecucaoDupontCores.fXmlPadraoRelMistQldToDataSet(
  const gravando: IGravando): TUniClientDataSet;
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
  strPat := strPat + '\PadraoRelMistQld.xml';

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

    if gravando.Status <> sgGravando then
      Exit;

    xmlNoInsert := xmlGen.ChildNodes.FindNode('xml').ChildNodes.FindNode('data');
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
      if gravando.Status <> sgGravando then
        Exit;

      Result.Insert;

      Result.FieldByName('RELACAO').Value                := xmlRegistro.Attributes['RELACAO'];
      Result.FieldByName('LINHA_PRODUTO').Value          := xmlRegistro.Attributes['LINHA_PRODUTO'];
      Result.FieldByName('DSCR_QUALIDADE').Value         := xmlRegistro.Attributes['DSCR_QUALIDADE'];
      Result.FieldByName('DSCR_TIPO_COMPONENTE').Value   := xmlRegistro.Attributes['DSCR_TIPO_COMPONENTE'];
      Result.FieldByName('COD_COMPONENTE_RELACAO').Value := xmlRegistro.Attributes['COD_COMPONENTE_RELACAO'];
      Result.FieldByName('VALOR').AsFloat                := fFormataFloatDupont(xmlRegistro.Attributes['VALOR']);

      Result.Post;

      xmlRegistro := xmlRegistro.NextSibling;
      gravando.RegistrarProgresso(0, intQtdAtual, intQtdRegistros);
      intQtdAtual := intQtdAtual + 1;
    End;
  Finally
    FreeAndNil(xmlGen);
  End;
end;

function TGravandoExecucaoDupontCores.fXmlProcurarValor(xmlNoPai: IXMLNode;
  strAtributo, valor: String): IXMLNode;
begin
  Result := xmlNoPai;

  While Assigned(Result) Do
  Begin

    If Result.Attributes[strAtributo] = valor Then
    Begin
      Exit;
    End;

    Result := Result.NextSibling;
  End;
end;

function TGravandoExecucaoDupontCores.fXmlToDataSet(
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
      if gravando.Status <> sgGravando then
        Exit;

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
