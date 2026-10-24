{*************************************************************************}
{* Classe responsável pela geração do cadastro de cores da tinta FarbenAutomotiva *}
{**********************************************************************PH*}
unit untGravandoExecucaoFarbenAutomotivaCores;

interface

uses
  untAbstractGravandoExecucaoFarbenAutomotiva, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, untAbstractCriadorTabela, ADODB,
  StrUtils, untTipoCadastro, untFloatUtils, Classes, Math, Uni,UniClientDataSet,
  InterBaseUniProvider, UniDataSetProvider;

type
  TGravandoExecucaoFarbenAutomotivaCores = class(TAbstractGravandoExecucaoFarbenAutomotiva)
  private
    function fSQLPrincipalCores(): String;
    function fSQLPrincipalCoresCount(): String;
    function fRetornaDescricaoProgramacao(strTipPrg: String): String;
    procedure pCalculaNovaQuantidadePrg3(qryCadCor: IDataSet; qryTintas: TUniQuery);
    function fVerificaFormulaCadastrada(strFormula: String; qryCadCor: IDataSet): Integer;
    function fVerificaCalculoNovaQuantidadePrg3(qryTintas: TUniQuery; qryBases: TUniQuery): Boolean;
    function fVerificaPrg2ComDiluido(qryTintas: TUniQuery; qryBases: TUniQuery): Boolean;
    procedure pCalculaNovaQuantidadePrg2ComDiluido(qryCadCor: IDataSet; qryTintas: TUniQuery);
  public
    constructor Create(const strCodNfm: string = '');
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untCriadorTabelas, untFuncoesGenerica;

{ TGravandoExecucaoFarbenAutomotivaCores }

constructor TGravandoExecucaoFarbenAutomotivaCores.Create(const strCodNfm: string);
begin
  inherited Create();
end;

procedure TGravandoExecucaoFarbenAutomotivaCores.Executar(const gravando: IGravando);
var
  Provider        : TInterbaseUniProvider;
  qryDestino      : IDataSet;
  qryCadFar       : IDataSet;

  strSQL          : String;
  strMd5          : String;
  intRegistro     : Integer;
  intTotalReg     : Integer;
  intFormQtd      : Integer;
  cdsDiluido      : TUniClientDataSet;
  qryArqTintas    : TUniQuery;
  qryArqBases     : TUniQuery;
  qryTotalReg     : TUniQuery;
  qryTotalRegCalc : TUniQuery;

  //Querys diluicao
  qryArqEprDil    : TUniQuery;
  qryArqEprCon    : TUniQuery;

  strCodPro   : String;
  strCodProAnt: String;
  fltTotFat   : Double;
  intCont     : Integer;
  intFormula  : Integer;

begin
  qryCadFar       := Nil;
  qryArqTintas    := Nil;
  qryArqBases     := Nil;
  qryTotalReg     := Nil;

  qryArqEprDil    := Nil;
  qryArqEprCon    := Nil;
  qryTotalRegCalc := Nil;

  cdsDiluido := fCriaClienteDataSet;

  strCodPro    := '';
  strCodProAnt := '';

  gravando.Texto := 'Validando Path de Arquivos ...';

  If (Not FileExists(GetPath)) Then
  Begin
    gravando.Texto := 'Path para o geração do arquivo de bases não é válido...';
    gravando.Cancelar;
    Exit;
  End;

  gravando.Texto := 'Path validado com sucesso ...';

  Try

    Provider := TInterbaseUniProvider.Create(Nil);

    Try
      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Excluindo os registros da tabela FAR_CADFAR...';

      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL := 'DELETE FROM FAR_CADFAR;';
      qryDestino.ExecSQL;

      gravando.Texto := 'Realizando conexão com banco de dados Firebird...';


      qryArqBases := TUniQuery.Create(Nil);
      qryArqBases.Connection := fConnectionFdb;
      qryArqBases.SQL.Clear;
      qryArqBases.Close;
      qryArqBases.SQL.Text := fSQLPrincipalCores;
      qryArqBases.Open;


      try
        qryTotalReg := TUniQuery.Create(Nil);
        qryTotalReg.Connection := fConnectionFdb;
        qryTotalReg.SQL.Clear;
        qryTotalReg.Close;
        qryTotalReg.SQL.Text := fSQLPrincipalCoresCount;
        qryTotalReg.Open;

        intTotalReg := qryTotalReg.fields[0].AsInteger;


      finally
        FreeAndNil(qryTotalReg);
      end;

      qryArqTintas := TUniQuery.Create(Nil);
      qryArqTintas.Connection := fConnectionFdb;

      intRegistro := 0;

      gravando.RegistrarProgresso(0,0,intTotalReg);

      qryArqBases.First;

      qryCadFar := TAutcomTintaFactory.Get.fGetDataSet;

      While not (qryArqBases.Eof)do
      begin
        strSQL := '';
        strSQL := ' SELECT * FROM ARQEPR ';

        if qryArqBases.FieldByName('DILUIDO').AsString = 'S' then
          strSQL := strSQL + ' WHERE DILUIDO = ''S'''
        else
          strSQL := strSQL + ' WHERE DILUIDO <> ''S''';

        strSQL := strSQL + ' AND PRG = ''' + qryArqBases.FieldByName('PRG').AsString + '''';

        strSQL := strSQL + ' AND CODPRO = ''' + qryArqBases.FieldByName('CODIGO').AsString + ''''+

                           ' ORDER BY CODMAT ';

        qryArqTintas.SQL.Clear;
        qryArqTintas.Close;
        qryArqTintas.SQL.Text := strSQL;
        qryArqTintas.Open;

        qryArqTintas.First;

        qryCadFar.Close;
        qryCadFar.SQL := 'SELECT * '+
                         '  FROM FAR_CADFAR '+
                         ' WHERE FAR_CODNFM  = :CODNFM '+
                         '   AND FAR_TIPPRG =  :TIPPRG ';
        qryCadFar.ParamByName('CODNFM').AsString := qryArqBases.FieldByName('CODIGO').AsString;
        qryCadFar.ParamByName('TIPPRG').AsString := qryArqBases.FieldByName('PRG').AsString;
        qryCadFar.Open;

        If Not (qryCadFar.IsEmpty) Then
        begin
          qryCadFar.Edit;

          While not (qryArqTintas.Eof)do
          begin
            intFormula := fVerificaFormulaCadastrada(qryArqTintas.FieldByName('CODMAT').AsString, qryCadFar);

            If (qryArqTintas.FieldByName('DILUIDO').AsString = 'S') And TStrUtils.fEmptyStr(qryCadFar.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intFormula, 2)).AsString) Then
              qryCadFar.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intFormula, 2)).AsString := Trim(qryArqTintas.FieldByName('CODMAT').AsString);

            If fVerificaCalculoNovaQuantidadePrg3(qryArqTintas, qryArqBases) Then
            Begin
              pCalculaNovaQuantidadePrg3(qryCadFar, qryArqTintas);
              Break;
            End;

            If fVerificaPrg2ComDiluido(qryArqTintas, qryArqBases) Then
            Begin
              pCalculaNovaQuantidadePrg2ComDiluido(qryCadFar, qryArqTintas);
              Break;
            End;

            if qryArqTintas.FieldByName('DILUIDO').AsString = 'S' then
            Begin
              qryCadFar.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intFormula, 2)).AsFloat  := qryArqTintas.FieldByName('QUANT').AsFloat;
            End
            Else
            Begin
              qryCadFar.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intFormula, 2)).AsFloat  := qryArqTintas.FieldByName('QUANT').AsFloat;
            End;


            qryArqTintas.Next;
          end;

          strMd5 := qryCadFar.FieldByName('FAR_MONTAD').AsString + qryCadFar.FieldByName('FAR_O_E_M_').AsString +
                    qryCadFar.FieldByName('FAR_A_N_O_').AsString + qryCadFar.FieldByName('FAR_DESCRI').AsString +
                    qryCadFar.FieldByName('FAR_SETOR_').AsString + qryCadFar.FieldByName('FAR_LINHA_').AsString +
                    qryCadFar.FieldByName('FAR_TIPPRG').AsString + qryCadFar.FieldByName('FAR_OBSERV').AsString +
                    qryCadFar.FieldByName('FAR_CODNFM').AsString;

          for intFormQtd := 1 to 20 do
          begin
            strMd5 := strMd5 + qryCadFar.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intFormQtd, 2)).AsString +
              StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intFormQtd, 2)).AsFloat), ',', '.', [rfReplaceAll]) +
              StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intFormQtd, 2)).AsFloat), ',', '.', [rfReplaceAll]);
          end;

          qryCadFar.FieldByName('FAR_MD5KEY').AsString := GetMD5(strMd5);

          qryCadFar.Post;
        end
        else
        begin
          qryCadFar.Insert;

          qryCadFar.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('FAR_CADFAR', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadFar.FieldByName('FAR_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadFar.FieldByName('FAR_CODSEQ').AsString := TStrUtils.fStrZero(qryArqBases.RecNo, 6);
          qryCadFar.FieldByName('FAR_MONTAD').AsString := qryArqBases.FieldByName('MONTADORA').AsString;
          qryCadFar.FieldByName('FAR_O_E_M_').AsString := qryArqBases.FieldByName('OEM').AsString;
          qryCadFar.FieldByName('FAR_A_N_O_').AsString := qryArqBases.FieldByName('ANO').AsString;
          qryCadFar.FieldByName('FAR_DESCRI').AsString := qryArqBases.FieldByName('DESCRICAO').AsString;
          qryCadFar.FieldByName('FAR_SETOR_').AsString := qryArqBases.FieldByName('SETOR').AsString;
          qryCadFar.FieldByName('FAR_LINHA_').AsString := qryArqBases.FieldByName('LINHA').AsString;
          qryCadFar.FieldByName('FAR_CODNFM').AsString := qryArqBases.FieldByName('CODIGO').AsString;
          qryCadFar.FieldByName('FAR_TIPPRG').AsString := qryArqBases.FieldByName('PRG').AsString;
          qryCadFar.FieldByName('FAR_OBSERV').AsString := qryArqBases.FieldByName('OBSFORM').AsString;
          qryCadFar.FieldByName('FAR_DESLIN').AsString := qryArqBases.FieldByName('DESLIN').AsString;
          qryCadFar.FieldByName('FAR_DESPRG').AsString := fRetornaDescricaoProgramacao(qryCadFar.FieldByName('FAR_TIPPRG').AsString);

          intFormQtd := 1;

          While not (qryArqTintas.eof) do
          begin
            qryCadFar.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intFormQtd, 2)).AsString := Trim(qryArqTintas.FieldByName('CODMAT').AsString);

            If fVerificaCalculoNovaQuantidadePrg3(qryArqTintas, qryArqBases) Then
            Begin
              pCalculaNovaQuantidadePrg3(qryCadFar, qryArqTintas);
              Break;
            End;

            If fVerificaPrg2ComDiluido(qryArqTintas, qryArqBases) Then
            Begin
              pCalculaNovaQuantidadePrg2ComDiluido(qryCadFar, qryArqTintas);
              Break;
            End;

            if qryArqTintas.FieldByName('DILUIDO').AsString = 'S' then
            Begin
              qryCadFar.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intFormQtd, 2)).AsFloat  := qryArqTintas.FieldByName('QUANT').AsFloat;
            End
            Else
            Begin
              qryCadFar.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intFormQtd, 2)).AsFloat  := qryArqTintas.FieldByName('QUANT').AsFloat;
            End;

            Inc(intFormQtd);

            qryArqTintas.Next;
          end;

          strMd5 := qryCadFar.FieldByName('FAR_MONTAD').AsString + qryCadFar.FieldByName('FAR_O_E_M_').AsString +
                    qryCadFar.FieldByName('FAR_A_N_O_').AsString + qryCadFar.FieldByName('FAR_DESCRI').AsString +
                    qryCadFar.FieldByName('FAR_SETOR_').AsString + qryCadFar.FieldByName('FAR_LINHA_').AsString +
                    qryCadFar.FieldByName('FAR_TIPPRG').AsString + qryCadFar.FieldByName('FAR_OBSERV').AsString +
                    qryCadFar.FieldByName('FAR_CODNFM').AsString;

          for intFormQtd := 1 to 20 do
          begin
            strMd5 := strMd5 + Trim(qryCadFar.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intFormQtd, 2)).AsString) +
              StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intFormQtd, 2)).AsFloat), ',', '.', [rfReplaceAll]) +
              StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intFormQtd, 2)).AsFloat), ',', '.', [rfReplaceAll]);
          end;

          qryCadFar.FieldByName('FAR_MD5KEY').AsString := GetMD5(strMd5);

          qryCadFar.Post;
        end;


        Inc(intRegistro);

        gravando.RegistrarProgresso(0,intRegistro,intTotalReg);

        if gravando.Status <> sgGravando then
          Exit;

          qryArqBases.Next;
      end;


      gravando.Texto := 'Aguarde, Localizando Basemix... ';

      qryArqEprCon := TUniQuery.Create(Nil);
      qryArqEprCon.Connection := fConnectionFdb;

      qryArqEprDil := TUniQuery.Create(Nil);
      qryArqEprDil.Connection := fConnectionFdb;
      qryArqEprDil.SQL.Clear;
      qryArqEprDil.Close;
      qryArqEprDil.SQL.Text := ' SELECT *               ' +
                               '   FROM ARQEPR E        ' +
                               '   JOIN ARQPRO P ON P.CODIGO = E.CODMAT ' +
                               '                AND P.PRG = E.PRG       ' +
                               '  WHERE E.DILUIDO = ''S''     ' +
                               '    AND P.PRG = ''3''         ' +
                               '    AND CODMAT <> ''558.400''   ' +
                               '    AND CODMAT <> ''558.000''   ' +
                               '  ORDER BY CODPRO             ';
      qryArqEprDil.Open;


      Try
        qryTotalRegCalc := TUniQuery.Create(Nil);
        qryTotalRegCalc.Connection := fConnectionFdb;
        qryTotalRegCalc.SQL.Clear;
        qryTotalRegCalc.Close;
        qryTotalRegCalc.SQL.Text := ' SELECT COUNT(*) ' +
                                    '   FROM ARQEPR E ' +
                                    '   JOIN ARQPRO P ON P.CODIGO = E.CODMAT ' +
                                    '                AND P.PRG = E.PRG       ' +
                                    '  WHERE E.DILUIDO = ''S'' ' +
                                    '    AND P.PRG = ''3'' ' +
                                    '    AND CODMAT <> ''558.400'' ' +
                                    '    AND CODMAT <> ''558.000'' ';
        qryTotalRegCalc.Open;

        intTotalReg := qryTotalRegCalc.fields[0].AsInteger;
      finally
        FreeAndNil(qryTotalRegCalc);
      end;

      gravando.Texto := 'Aguarde, Iniciando Atualização Basemix... ';

      gravando.RegistrarProgresso(0, 0, intTotalReg);


      intRegistro := 0;

      qryArqEprDil.First;

      While Not qryArqEprDil.Eof Do
      Begin
        //gravando.Texto := '340';

        strCodPro := qryArqEprDil.FieldByName('CODPRO').AsString;

        If TStrUtils.fEmptyStr(strCodProAnt) Or (strCodProAnt = strCodPro) Then
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT *       ';
          strSQL := strSQL + '   FROM ARQEPR  ';
          strSQL := strSQL + '  WHERE CODPRO  = :CODPRO    ';
          strSQL := strSQL + '    AND PRG     = ''2''      ';
          strSQL := strSQL + '    AND CODMAT  = :CODMAS    ';
          strSQL := strSQL + '    AND DILUIDO <> ''S''     ';


          qryArqEprCon.Close;
          qryArqEprCon.SQL.Clear;
          qryArqEprCon.SQL.Text := strSQL;
          qryArqEprCon.ParamByName('CODPRO').AsString := qryArqEprDil.FieldByName('CODPRO').AsString;
          qryArqEprCon.ParamByName('CODMAS').AsString := qryArqEprDil.FieldByName('COD_MASTER').AsString;
          qryArqEprCon.Open;

         // gravando.Texto := '362';

          cdsDiluido.Append;
          cdsDiluido.FieldByName('CODPRO').AsString := qryArqEprDil.FieldByName('CODPRO').AsString;
          cdsDiluido.FieldByName('CODBAS').AsString := qryArqEprDil.FieldByName('CODMAT').AsString;
          cdsDiluido.FieldByName('FATOR').AsFloat   := ((qryArqEprCon.FieldByName('QUANT').AsFloat * 100) / qryArqEprDil.FieldByName('PER_COBERTURA').AsFloat);
          cdsDiluido.FieldByName('QTDBAS').AsFloat  := qryArqEprCon.FieldByName('QUANT').AsFloat;
          cdsDiluido.Post;

          //gravando.Texto := '371';

          strCodProAnt := qryArqEprDil.FieldByName('CODPRO').AsString;

        //  gravando.Texto := '376';

        End
        Else
        Begin

          fltTotFat := 0;

          cdsDiluido.First;


          While Not cdsDiluido.Eof Do
          Begin
           // gravando.Texto := '389';

            fltTotFat := fltTotFat + cdsDiluido.FieldByName('FATOR').AsFloat;

            //gravando.Texto := '393';

            cdsDiluido.Next;
          End;

          cdsDiluido.First;

          While Not cdsDiluido.Eof Do
          Begin
          //  gravando.Texto := '402';
            cdsDiluido.Edit;
            cdsDiluido.FieldByName('QTDCON').AsFloat := ((cdsDiluido.FieldByName('FATOR').AsFloat * 100) / fltTotFat);
            cdsDiluido.Post;

          //  gravando.Texto := '407';

            cdsDiluido.Next;
          End;

          qryCadFar.Close;
          qryCadFar.SQL := ' SELECT * ' +
                           '   FROM FAR_CADFAR ' +
                           '  WHERE FAR_CODNFM = :CODPRO ' +
                           '    AND FAR_TIPPRG = ''2'' ';

          qryCadFar.ParamByName('CODPRO').AsString := strCodProAnt;
          qryCadFar.Open;

          //gravando.Texto := '421';

          If Not qryCadFar.IsEmpty Then
          Begin
            qryCadFar.Close;
            qryCadFar.SQL := ' SELECT * ' +
                             '   FROM FAR_CADFAR ' +
                             '  WHERE FAR_CODNFM = :CODPRO ' +
                             '    AND FAR_TIPPRG = ''3'' ' +
                             '    AND (FAR_QTDC01 IS NULL OR FAR_QTDC01 = '''') ';

            qryCadFar.ParamByName('CODPRO').AsString := strCodProAnt;
            qryCadFar.Open;

           // gravando.Texto := '434';

            intCont := 1;

            If Not qryCadFar.IsEmpty Then
            Begin
              Try
                cdsDiluido.First;
                While Not cdsDiluido.Eof Do
                Begin
                  //gravando.Texto := '444';

                  qryCadFar.Edit;
                  qryCadFar.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intCont,2)).AsFloat := cdsDiluido.FieldByName('QTDCON').AsFloat;
                  qryCadFar.Post;

                 // gravando.Texto := '450';

                  intCont := intCont + 1;

                  cdsDiluido.Next;
                End;
              Except
                On E:Exception Do
                begin
                  gravando.Cancelar;
                  gravando.Texto := 'Ocorreu erro ao processar o cadastro.' + e.Message;
                end;
              End;
            End;
          End;


          cdsDiluido.EmptyDataSet;
          strCodProAnt := '';

          Continue;
        End;


        Inc(intRegistro);

        gravando.RegistrarProgresso(0,intRegistro,intTotalReg);

        qryArqEprDil.Next;
      End;

    except on  e : Exception do
      begin
        gravando.Texto := 'Ocorreu erro ao processar o cadastro.' + #13 + e.Message ;
        gravando.RegistrarProgresso(0, 0, 0);
        gravando.Cancelar;
      end;
    end;
  finally
    gravando.Texto := 'Geração conluída com sucesso!';
    If Assigned(qryArqBases) Then
      FreeAndNil(qryArqBases);

    If Assigned(qryArqTintas) Then
      FreeAndNil(qryArqTintas);

    If Assigned(qryArqEprCon) Then
      FreeAndNil(qryArqEprCon);

    If Assigned(qryArqEprDil) Then
      FreeAndNil(qryArqEprDil);

    If Assigned(cdsDiluido) Then
      FreeAndNil(cdsDiluido);

    if Assigned(Provider) Then
      FreeAndNil(Provider);

  end;

end;

function TGravandoExecucaoFarbenAutomotivaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;



function TGravandoExecucaoFarbenAutomotivaCores.fRetornaDescricaoProgramacao(
  strTipPrg: String): String;
begin
  Result := '';

  If strTipPrg = '1' Then
    Result := 'FARBEMIX'
  Else If strTipPrg = '2' Then
    Result := 'MASTERMIX'
  Else If strTipPrg = '3' Then
    Result := 'BASEMIX';
end;

function TGravandoExecucaoFarbenAutomotivaCores.fSQLPrincipalCores: String;
begin
  Result := '';
  Result := Result + '  SELECT                        ';
  Result := Result + '    P.PRG AS PRG,               ';
  Result := Result + '    P.CODIGO AS CODIGO,         ';
  Result := Result + '    P.DILUIDO AS DILUIDO,       ';
  Result := Result + '    P.MONTADORA AS MONTADORA,   ';
  Result := Result + '    P.OEM AS OEM,               ';
  Result := Result + '    P.ANO AS ANO,               ';
  Result := Result + '    P.DESCRICAO AS DESCRICAO,   ';
  Result := Result + '    P.SETOR AS SETOR,           ';
  Result := Result + '    P.LINHA AS LINHA,           ';
  Result := Result + '    P.OBSFORM AS OBSFORM,       ';
  Result := Result + '    L.DESCRICAO AS DESLIN       ';
  Result := Result + '  FROM                          ';
  Result := Result + '    ARQPRO P                    ';
  Result := Result + '  LEFT JOIN ARQGRP L ON         ';
  Result := Result + '    P.SETOR = L.SETOR AND       ';
  Result := Result + '    P.LINHA = L.CODGRP AND      ';
  Result := Result + '    P.PRG = L.PRG               ';
  Result := Result + '  WHERE                         ';
  Result := Result + '    P.ORIGEM <> ''MP''          ';
  Result := Result + '  ORDER BY P.CODIGO             ';
end;

function TGravandoExecucaoFarbenAutomotivaCores.fSQLPrincipalCoresCount: String;
begin
  Result := '';
  Result := Result + '  SELECT COUNT(*)             ';
  Result := Result + '    FROM ARQPRO               ';
  Result := Result + '  LEFT JOIN ARQGRP ON         ';
  Result := Result + '    ARQPRO.SETOR = ARQGRP.SETOR AND     ';
  Result := Result + '    ARQPRO.LINHA = ARQGRP.CODGRP AND    ';
  Result := Result + '    ARQPRO.PRG = ARQGRP.PRG             ';
  Result := Result + '  WHERE ARQPRO.ORIGEM <> ''MP''         ';
end;

function TGravandoExecucaoFarbenAutomotivaCores.fVerificaCalculoNovaQuantidadePrg3(
  qryTintas: TUniQuery; qryBases: TUniQuery): Boolean;
begin
  Result := False;

  If qryTintas.FieldByName('PRG').AsString <> '3' Then
  Begin
    Result := False;
    Exit;
  End;

  If qryBases.FieldByName('LINHA').AsString <> 'PE' Then
  Begin
    Result := False;
    Exit;
  End;

  If qryTintas.FieldByName('DILUIDO').AsString = 'S' Then
  Begin
    Result := False;
    Exit;
  End;

  If Trim(qryTintas.FieldByName('CODMAT').AsString) = '558.400' Then
  Begin
    Result := True;
    Exit;
  End;

  If Trim(qryTintas.FieldByName('CODMAT').AsString) = '558.000' Then
  Begin
    Result := True;
    Exit;
  End;
end;

function TGravandoExecucaoFarbenAutomotivaCores.fVerificaFormulaCadastrada(
  strFormula: String; qryCadCor: IDataSet): Integer;
Var
  intContador: Integer;
  intResult: Integer;
begin
  Result := 1;
  intResult := 1;


  For intContador := 1 To 20 Do
  Begin
    If Trim(strFormula) = qryCadCor.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString Then
    Begin
      Result := intResult;
      Break;
    End;

    If TStrUtils.fEmptyStr(qryCadCor.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
    Begin
      Result := intResult;
      Break;
    End;

    intResult := IntResult + 1;
  End;
end;

function TGravandoExecucaoFarbenAutomotivaCores.fVerificaPrg2ComDiluido(
  qryTintas, qryBases: TUniQuery): Boolean;
begin
  Result := False;

  If (Trim(qryTintas.FieldByName('PRG').AsString) = '2') And (qryTintas.FieldByName('DILUIDO').AsString <> 'S') Then
  Begin
    If Trim(qryTintas.FieldByName('CODMAT').AsString) = '558.400' Then
    Begin
      Result := True;
      Exit;
    End;

    If Trim(qryTintas.FieldByName('CODMAT').AsString) = '558.000' Then
    Begin
      Result := True;
      Exit;
    End;

    If Trim(qryTintas.FieldByName('CODMAT').AsString) = 'UC700' Then
    Begin
      Result := True;
      Exit;
    End;

    If Trim(qryTintas.FieldByName('CODMAT').AsString) = 'UC800' Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

procedure TGravandoExecucaoFarbenAutomotivaCores.pCalculaNovaQuantidadePrg2ComDiluido(
  qryCadCor: IDataSet; qryTintas: TUniQuery);
Var
  intFormQtd: Integer;
  intContador: Integer;
begin
  intFormQtd := 1;
  qryTintas.First;

  For intContador := 1 To 20 Do
  Begin
    qryCadCor.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := '';
    qryCadCor.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 0;
  End;

  While Not qryTintas.Eof Do
  Begin
    qryCadCor.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intFormQtd, 2)).AsString := Trim(qryTintas.FieldByName('CODMAT').AsString);
    qryCadCor.FieldByName('FAR_QTDD' + TStrUtils.fStrZero(intFormQtd, 2)).AsFloat := qryTintas.FieldByName('QUANT').AsFloat;

    Inc(intFormQtd);
    qryTintas.Next;
  End;
end;

procedure TGravandoExecucaoFarbenAutomotivaCores.pCalculaNovaQuantidadePrg3(
  qryCadCor: IDataSet; qryTintas: TUniQuery);
Var
  intFormQtd: Integer;
  intContador: Integer;
begin
  intFormQtd := 1;
  qryTintas.First;

  For intContador := 1 To 20 Do
  Begin
    qryCadCor.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString := '';
    qryCadCor.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 0;
  End;

  While Not qryTintas.Eof Do
  Begin
    If Trim(qryTintas.FieldByName('CODMAT').AsString) = '558.400' Then
      Break;

    If Trim(qryTintas.FieldByName('CODMAT').AsString) = '558.000' Then
      Break;

    qryCadCor.FieldByName('FAR_CODB' + TStrUtils.fStrZero(intFormQtd, 2)).AsString := Trim(qryTintas.FieldByName('CODMAT').AsString);
    qryCadCor.FieldByName('FAR_QTDC' + TStrUtils.fStrZero(intFormQtd, 2)).AsFloat := qryTintas.FieldByName('QUANT').AsFloat * 1.8;

    Inc(intFormQtd);

    qryTintas.Next;
  End;
end;

end.
