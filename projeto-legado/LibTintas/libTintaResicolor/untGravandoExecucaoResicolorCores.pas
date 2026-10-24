{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta Resicolor *}
{**********************************************************************PH*}
unit untGravandoExecucaoResicolorCores;

interface

uses
  untAbstractGravandoExecucaoResicolor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, Math, ADODB, Classes,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TGravandoExecucaoResicolorCores = class(TAbstractGravandoExecucaoResicolor)
  private
    procedure pExcluindoMDDuplicadosRSI(const Gravando: IGravando);
    function fRetornaIdProd(strPathPro:String): String;
    function fRetProCodEmbalagem(strEmbOrigem, strDescri: String; intCont, intMax: Integer): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoResicolorCores }

procedure TGravandoExecucaoResicolorCores.Executar(const gravando: IGravando);
Var
  intProducts : Integer;
  intSubProds : Integer;
  intFrm      : Integer;
  intMask     : Integer;
  intPos      : Integer;

  strProKey   : String;
  strPatPro   : String;
  strPatSub   : String;
  strSubKey   : String;
  strBaseSe   : String;
  strEmbCom   : String;
  strFormula  : String;
  strKey2     : String;

  arrColRsi   : Array Of TColRsi;
  strQtdEmb   : String;
  strDesTin   : String;
  intColora   : Integer;
  intCodSeq   : Integer;
  intQtdRegFrm: Integer;
  strSQLBase  : String;
  strIdPro    : String;
  MaxEmbalagem: Integer;
  qryInsert: TFDQuery;
  intQtdParam: Integer;
begin
  Try
    Try
      Gravando.Texto := 'Verificando path do arquivo...';

      If Not DirectoryExists(GetPathPro) Then
      Begin
        Gravando.Texto := Format('O diretorio %s não existe!', [AnsiReplaceStr(GetPathPro, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Path verificado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Fórmulas...';

      blnQtdRgt := False;
      pCarregarProdutos;
      pCarregarBases;
      pPreencheQryCadBas;

      intCodSeq := 1;

      qryInsert := TFDQuery.Create(Nil);
      qryInsert.Connection := FDDatabase;
      qryInsert.Close;



      strSQLBase := tblBases.SQL.Text;

      If TAutcomTintaFactory.Get.fMensagem('', 'Deseja excluir o cadastro de fórmulas?', ['&Sim', '&Não']) = 1 Then
      Begin
        Gravando.Texto := 'Deletando Cadastro de Fórmulas...';
        qryRSI_CADRSI.Close;
        qryRSI_CADRSI.SQL.Empty;
        qryRSI_CADRSI.SQL := '    DELETE FROM RSI_CADRSI    ';
        qryRSI_CADRSI.ExecSQL;
        qryRSI_CADRSI.SQL.Empty;
        Gravando.Texto := 'Cadastro de Fórmulas deletado...';
      End;

      qryRSI_CADRSI.SQL := '    SELECT * FROM RSI_CADRSI WHERE FALSE    ';
      qryRSI_CADRSI.Open;

      Gravando.Texto := 'Verificando Cadastro de Embalagem...';

      If Not fVerificaCadastroEmbalagem() Then
      Begin
        If qryRSI_CADRSI.IsEmpty Then
        Begin
          If TAutcomTintaFactory.Get.fMensagem('', 'O cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
          Begin
            Try
              pImportarCadastroEmbalagem(Gravando);
              Gravando.Texto := 'Cadastro de Embalagem processado com sucesso...';
              Gravando.RegistrarProgresso(0, 0, 0);
            Except
              On E: Exception Do
              Begin
                Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
                Exit;
              End;
            End;
          End;
        End
        Else
        Begin
          Gravando.Texto := 'O cadastro de Embalagem está inconsistente!';
          Gravando.Texto := 'Para continuar deve importar o Cadastro de Embalagem...';
        End;

        Exit;
      End;

      Gravando.Texto := 'Verificando Cadastro de Bases e Colorantes...';

      If Not fVerificaCadastroBases Then
      Begin
        Gravando.Texto := 'O Cadastro de bases está vazio...';
        Exit;
      End;

      If Not fVerificaCadastroColorante Then
      Begin
        Gravando.Texto := 'O Cadastro de colorantes está vazio...';
        Exit;
      End;

      Gravando.Texto := 'Cadastro de Bases e Colorantes verificado...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('RSI_CADRSI');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Processando arquivos do Cadastro de Fórmulas...';

      For intProducts := 1 To 1 Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        strIdPro := fRetornaIdProd(GetPathPro);

        strPatPro := GetPathPro;
        strProKey := TStrUtils.fStrZero(Trim(strIdPro), 2);

        Gravando.Texto := Format('Processando Produto: [%s]',[AnsiReplaceStr(strPatPro, '"', '')]);

        pCarregarSubProdutos(strPatPro);

        For intSubProds := 1 To tblSubProds.RecordCount Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strPatSub := strPatPro + '\' + tblSubProds.FieldByName('PATH').AsString;
          strSubKey := TStrUtils.fStrZero(Trim(tblSubProds.FieldByName('ID').AsString), 2);

          pCarregarFrm(strPatPro, strPatSub, Gravando);
          Gravando.Texto := Format('Processando Subproduto: [%s]', [AnsiReplaceStr(strPatSub, '"', '')]);
          pCarregarMask(strPatSub);
          pCarregarRuler(strPatSub);
          pPreencherRuler();

          intQtdRegFrm := qryFrm.RecordCount;
          qryInsert.SQL.Text := fGravarCadastroResicolor(intCodSeq, strBaseSe, strProKey, strSubKey, arrColRsi, strDesTin, strQtdEmb, strKey2, Gravando, strEmbCom);
          qryInsert.Params.ClearValues();
          qryInsert.Params.ArraySize := intQtdRegFrm * 3;
          intQtdParam := 0;

          For intFrm := 1 To intQtdRegFrm Do
          Begin

            If (Gravando.Status <> sgGravando) Then
              Break;

            strBaseSe := TStrUtils.fStrZero(Trim(qryFrm.FieldByName('BASE_ID').AsString), 2);

            If strBaseSe = '00' Then
              Continue;

            strEmbCom := TStrUtils.fStrZero(Trim(qryFrm.FieldByName('CAN_ID').AsString), 2);

            cdsCadRuler.Locate('ID', Trim(qryFrm.FieldByName('BASE_ID').AsString), []);

            If (Pos('TEXTURA_RAFIATTO_', tblSubProds.FieldByName('DESCR').AsString) > 0) Or
             (strEmbCom = '08') Or (strEmbCom = '09') Then
              MaxEmbalagem := 2
            Else
              MaxEmbalagem := 3;

            strFormula := qryFrm.FieldByName('FORMULA').AsString;
            SetLength(arrColRsi, 0);

            For intMask := 1 To MaxEmbalagem Do
            Begin

              If (Gravando.Status <> sgGravando) Then
                Break;


              While Not TStrUtils.fEmptyStr(strFormula) Do
              Begin
                SetLength(arrColRsi, Length(arrColRsi) + 1);
                intPos := Pos(',', strFormula);

                arrColRsi[Length(arrColRsi) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);

                strFormula := Copy(strFormula, intPos + 1 , Length(strFormula));
                intPos := Pos(',', strFormula);

                If intPos <= 0 Then
                  intPos := Length(strFormula) + 1;

                arrColRsi[Length(arrColRsi) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ',')) * 0.616125 *
                  TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Trim(cdsCadRuler.FieldByName('RULE').AsString), '.', ','));

                strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
              End;

              SetLength(arrColRsi, 20);
              strQtdEmb := TStrUtils.fStrZero(Trim(fRetProCodEmbalagem(Trim(qryFrm.FieldByName('CAN_ID').AsString), tblSubProds.FieldByName('DESCR').AsString,
                intMask, MaxEmbalagem)), 2);

              Begin
                cdsCadBas.First;
                Begin

                  If Not cdsCadBas.Locate('ID;PROD_KEY;SUBP_KEY', VarArrayOf([qryFrm.FieldByName('BASE_ID').AsString,
                    Trim(strIdPro), Trim(tblSubProds.FieldByName('ID').AsString)]), []) Then
                    Continue;

                  If Trim(cdsCadBas.FieldByName('ID').AsString) <> Trim(qryFrm.FieldByName('BASE_ID').AsString) Then
                  Begin
                    Continue;
                  End;

                  If Trim(cdsCadBas.FieldByName('PROD_KEY').AsString) <> Trim(strIdPro) Then
                  Begin
                    Continue;
                  End;

                  If Trim(cdsCadBas.FieldByName('SUBP_KEY').AsString) <> Trim(tblSubProds.FieldByName('ID').AsString) Then
                  Begin
                    Continue;
                  End;

                  If Not qryRSI_CADBAS.Locate('BAS_BASE__;BAS_PROKEY;BAS_SUBKEY;BAS_UNIDAD', VarArrayOf([
                    strBaseSe, strProKey, strSubKey, fRetUnidadeEmbalagem(strQtdEmb)]), []) Then
                  Begin
                    Continue;
                  End;


                  strDesTin := AnsiUpperCase(
                    qryFrm.FieldByName('KEY1').AsString + ' ' +
                    Trim(tblSubProds.FieldByName('DESCR').AsString) + ' ' +
                    qryFrm.FieldByName('KEY3').AsString);

                  strKey2   := qryFrm.FieldByName('KEY2').AsString;

                  qryInsert.ParamByName('RSI_CODSEQ').AsStrings[intQtdParam] := TStrUtils.fStrZero(intCodSeq, 15);
                  qryInsert.ParamByName('RSI_DESCRI').AsStrings[intQtdParam] := strDesTin;
                  qryInsert.ParamByName('RSI_CODIGO').AsStrings[intQtdParam] := qryFrm.FieldByName('KEY1').AsString;
                  qryInsert.ParamByName('RSI_CODIG2').AsStrings[intQtdParam] := AnsiUpperCase(qryFrm.FieldByName('KEY3').AsString);
                  qryInsert.ParamByName('RSI_UNIDAD').AsStrings[intQtdParam] := fRetUnidadeEmbalagem(strQtdEmb);
                  qryInsert.ParamByName('RSI_CODEMP').AsStrings[intQtdParam] := TAutcomTintaFactory.Get.GetCodEmp;
                  qryInsert.ParamByName('RSI_BASE__').AsStrings[intQtdParam] := qryRSI_CADBAS.FieldByName('BAS_BASE__').AsString;
                  qryInsert.ParamByName('RSI_PROKEY').AsStrings[intQtdParam] := qryRSI_CADBAS.FieldByName('BAS_PROKEY').AsString;
                  qryInsert.ParamByName('RSI_SUBKEY').AsStrings[intQtdParam] := qryRSI_CADBAS.FieldByName('BAS_SUBKEY').AsString;

                  For intColora := 1 To 20 Do
                  Begin
                    qryInsert.ParamByName('RSI_FORM' + TStrUtils.fStrZero(intColora, 2)).AsStrings[intQtdParam] := arrColRsi[intColora - 1].strCodCol;
                    qryInsert.ParamByName('RSI_QTDB' + TStrUtils.fStrZero(intColora, 2)).AsFloats[intQtdParam] := fCalQtdEmb(arrColRsi[intColora - 1].fltQtdCol, strEmbCom, strQtdEmb);
                  End;

                  qryInsert.ParamByName('RSI_MD5KEY').AsStrings[intQtdParam] := GetMD5(qryInsert.ParamByName('RSI_DESCRI').AsStrings[intQtdParam] +
                                                                             strKey2 +
                                                                             fRetUnidadeEmbalagem(strQtdEmb) +
                                                                             qryRSI_CADBAS.FieldByName('BAS_BASE__').AsString +
                                                                             qryFrm.FieldByName('KEY1').AsString +
                                                                             qryRSI_CADBAS.FieldByName('BAS_PROKEY').AsString +
                                                                             qryRSI_CADBAS.FieldByName('BAS_SUBKEY').AsString);

                  Inc(intQtdParam);
                  Inc(intCodSeq);
                End;
              End;
            End;

            qryFrm.Next;
            Gravando.RegistrarProgresso(0, qryFrm.RecNo, qryFrm.RecordCount);
          End;
          If intQtdParam > 0 Then
            qryInsert.Execute(intQtdParam, 0);
          tblSubProds.Next;
          Gravando.RegistrarProgresso(0, tblSubProds.RecNo, tblSubProds.RecordCount);
        End;
        Gravando.RegistrarProgresso(0, 1, 1);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    pExcluindoMDDuplicadosRSI(Gravando);
    Gravando.Texto := 'Cadastro de Fórmulas processado com sucesso...';
  End;

  Gravando.Texto := 'Processando Cadastro de Novas Fórmulas...';

  While Not qryRSI_CADNFM.Eof Do
  Begin
    Try

      If (Gravando.Status <> sgGravando) Then
        Break;

      fGravarNovasFormulas(qryRSI_CADNFM, Gravando);
      qryRSI_CADNFM.Next;
      Gravando.RegistrarProgresso(0, qryRSI_CADNFM.RecNo, qryRSI_CADRSI.RecordCount);
    Finally
      Gravando.Texto := 'Cadastro de Novas Fórmulas processado!';
    End;
  End;
end;


function TGravandoExecucaoResicolorCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoResicolorCores.fRetornaIdProd(
  strPathPro: String): String;
begin
  Result := '';

  If Pos('PROD0014', strPathPro) > 0 Then
    Result := '   14'
  Else If Pos('PROD0001', strPathPro) > 0 Then
    Result := '    1'
  Else If Pos('PROD0002', strPathPro) > 0 Then
    Result := '    2'
  Else If Pos('PROD0003', strPathPro) > 0 Then
    Result := '    3'
  Else If Pos('PROD0004', strPathPro) > 0 Then
    Result := '    4'
  Else If Pos('PROD0005', strPathPro) > 0 Then
    Result := '    5'
  Else If Pos('PROD0006', strPathPro) > 0 Then
    Result := '    6'
  Else If Pos('PROD0010', strPathPro) > 0 Then
    Result := '   10'
  Else If Pos('PROD0007', strPathPro) > 0 Then
    Result := '    7'
  Else If Pos('PROD0013', strPathPro) > 0 Then
    Result := '   13'
  Else If Pos('PROD0008', strPathPro) > 0 Then
    Result := '    8'
  Else If Pos('PROD0009', strPathPro) > 0 Then
    Result := '    9'
  Else If Pos('PROD0012', strPathPro) > 0 Then
    Result := '   12'
  Else If Pos('PROD0011', strPathPro) > 0 Then
    Result := '   11';
end;

function TGravandoExecucaoResicolorCores.fRetProCodEmbalagem(strEmbOrigem,
  strDescri: String; intCont, intMax: Integer): String;
Var
  intCodEmb: Integer;
begin
  Result := '';
  intCodEmb := StrToInt(strEmbOrigem);

  If (intMax = 2) And (Pos('TEXTURA_', strDescri) > 0) Or (strEmbOrigem = '8') Then
  Begin
    If intCont = 1 Then
      Result := TStrUtils.fStrZero(strEmbOrigem, 2)
    Else
      Result := TStrUtils.fStrZero(IntToStr(intCodEmb - 1), 2);
  End
  Else If (intMax = 2) And (Pos('RAFIATTO_', strDescri) > 0) Or (strEmbOrigem = '9') Then
  Begin
    If intCont = 1 Then
      Result := TStrUtils.fStrZero(strEmbOrigem, 2)
    Else
      Result := TStrUtils.fStrZero(IntToStr(intCodEmb + 1), 2);
  End
  Else If (intMax = 3) Then
  Begin
    If intCont = 1 Then
      Result := TStrUtils.fStrZero(strEmbOrigem, 2)
    Else If intCont = 2 Then
      Result := TStrUtils.fStrZero(IntToStr(intCodEmb + 1), 2)
    Else If intCont = 3 Then
      Result := TStrUtils.fStrZero(IntToStr(intCodEmb + 2), 2);
  End;
end;

procedure TGravandoExecucaoResicolorCores.pExcluindoMDDuplicadosRSI(
  const Gravando: IGravando);
var
  qryGen: IDataSet;
  qryMD5: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT COUNT(*) AS QTD, ' +
                '        RSI_MD5KEY       ' +
                '   FROM RSI_CADRSI       ' +
                '  GROUP BY RSI_MD5KEY    ' +
                ' HAVING COUNT(*) > 1     ';
  qryGen.Open;

  If Not qryGen.IsEmpty Then
  Begin
    gravando.Texto := 'Excluindo arquivos duplicados RSI_CADRSI...';

    qryMD5 := TAutcomTintaFactory.Get.fGetDataSet;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      qryMD5.SQL := ' DELETE '+
                    '   FROM RSI_CADRSI ' +
                    '  WHERE RSI_MD5KEY = :MD5 ' +
                    '  LIMIT ' + IntToStr(qryGen.FieldByName('QTD').AsInteger - 1);

      qryMD5.ParamByName('MD5').AsString := qryGen.FieldByName('RSI_MD5KEY').AsString;
      qryMD5.ExecSQL;

      gravando.RegistrarProgresso(0, qryGen.RecNo, qryGen.RecordCount);

      qryGen.Next;
    End;

  End;
end;

end.

