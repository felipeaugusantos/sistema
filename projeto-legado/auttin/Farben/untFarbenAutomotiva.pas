unit untFarbenAutomotiva;

interface
{$M+}

uses
  SysUtils, Uni, ExtCtrls, Classes,
  Dialogs, Forms, DB, UniClientDataSet, UniDataSetProvider,
  untTintadeMaquina, InterBaseUniProvider;

Type
  TEventoSimples = procedure of object;

  TFarbenAutomotivaNfm = class(TTintadeMaquina)
  private
    qryCadFar    : TUniQuery;
  protected

  public
    function fGravarNovasFormulas: Boolean; override;
    class function fGravarNovaFormula(qryCadNfm : TUniQuery): Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TFarbenAutomotiva = class
  private
    qryCadFar : TUniQuery;
    qryCadBas : TUniQuery;
    Provider  : TInterbaseUniProvider;

    FRegistraProgresso  : TEventoProgresso;
    FRegistraAcao       : TEventoStrAcao;
    FCancelarProcesso   : Boolean;

    cdsDiluido: TUniClientDataSet;

    function fCriaClienteDataSet: TUniClientDataSet;
  protected
    procedure pRegistraAcao(strAcao: String);
    procedure pRegistraProgresso(intInicio: Integer; intAtual: Integer; intFinal: Integer);

  public
    qryCadNfm : TUniQuery;
    dtsCadNfm : TDataSource;


    procedure pIniciaCadNfm;

    function fConnectionFdb : TUniConnection;
    function fCadBasVazia: Boolean;

    function fProcessarBases: Boolean;
    function fProcessarTintas : Boolean;
    function fProcessarArquivoFdb(blnBases: Boolean): boolean;


    constructor Create;
    destructor Destroy; override;
  published
    property RegistraAcao: TEventoStrAcao read FRegistraAcao write FRegistraAcao;
    property RegistraProgresso: TEventoProgresso read FRegistraProgresso write FRegistraProgresso;
    property CancelarProcesso : Boolean read  FCancelarProcesso Write FCancelarProcesso;

  end;

  function fRetUltCodSeq: Integer;
  procedure pExcluirNfm(strCodigo: String);

implementation

uses untConstantes, untFuncoesSimples, untIConfTinta, untFuncTinta, Variants,
  untModulo;
{ TFarbenAutomotiva }

constructor TFarbenAutomotiva.Create;
begin
  Provider  := TInterbaseUniProvider.Create(Nil);
  qryCadFar := fCriaQuery;
  qryCadBas := fCriaQuery;
  qryCadNfm := fCriaQuery;

end;

destructor TFarbenAutomotiva.Destroy;
begin
  FreeAndNil(Provider);
  FreeAndNil(qryCadFar);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadNfm);
end;


function TFarbenAutomotiva.fConnectionFdb: TUniConnection;
Var
  conf   : IConfTinta;
  Con    : TUniConnection;
  StrDll : String;
begin
  conf  := fGetConfTinta('FAR');

  Con := TUniConnection.Create(nil);

  try
    Con.Database     := conf.fGet('FARPAT');
    Con.Username     := conf.fGet('FARUSU');
    Con.Password     := conf.fGet('FARSEN');

    if (conf.fGet('FARSER') <> 'LOCALHOST' ) then
    begin
      Con.Server       := conf.fGet('FARSER');
      Con.Port         := conf.fGetInteger('FARPOR');
    end;

    Con.ProviderName := 'Interbase';
    Con.Connect;

    Result := Con;

  except on e : Exception do
    begin
      Result := Nil;

      StrDll := e.message;

      StrDll := copy(StrDll, pos(',', StrDll)+1,length(StrDll));
      StrDll := copy(StrDll, pos(':', StrDll)+1,length(StrDll));

      StrDll := UpperCase(StrDll);

      If (Pos(Copy(StrDll, (Length(StrDll) - 3) , Length(StrDll)),'.DLL') > 0) Then
        fMensagem('ATENÇÃO!', 'Não foi possível realizar a integração com o banco de dados, pois o arquivo '+ StrDll +' não foi encontrado.', ['&OK'])
      else
        fMensagem('ATENÇÃO!', 'Erro ao tentar conexão com o banco de dados!', ['&OK']);
    end;
  end;
end;

function TFarbenAutomotiva.fCriaClienteDataSet: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODPRO';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODBAS';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'FATOR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDBAS';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'QTDCON';
    DataType := ftFloat;
  End;
  Result.CreateDataSet;
end;

function TFarbenAutomotiva.fProcessarArquivoFdb(blnBases: Boolean): boolean;
begin

  try
    if (blnBases) then
      Result := fProcessarBases
    else
    begin
      Result := fProcessarTintas;
    end;

  except on e : Exception do
    begin
     fMensagem('ATENÇÃO!', 'Erro ao processar os arquivos!', ['&OK']);
      Result := false;
    end;
  end;

end;

function TFarbenAutomotiva.fProcessarTintas: Boolean;
var
  strSQL        : String;
  strMd5        : String;

  intRegistro   : Integer;
  intTotalReg   : Integer;
  intFormQtd    : Integer;
  qryArqTintas  : TUniQuery;
  qryArqBases   : TUniQuery;
  qryCadFar     : TUniQuery;
  qryTotalReg   : TUniQuery;
  farbenNfm     : TFarbenAutomotivaNfm;
  qryTotalRegCalc   : TUniQuery;

  //Querys diluicao
  qryArqEprDil  : TUniQuery;
  qryArqEprCon  : TUniQuery;

  strCodPro: String;
  strCodProAnt: String;
  fltTotFat: Double;
  intCont: Integer;
begin
  farbenNfm    := Nil;
  qryCadFar    := Nil;
  qryArqTintas := Nil;
  qryArqBases  := Nil;
  qryTotalReg  := Nil;

  qryArqEprDil := Nil;
  qryArqEprCon := Nil;
  qryTotalRegCalc := Nil;

  cdsDiluido := fCriaClienteDataSet;

  strCodPro := '';
  strCodProAnt := '';

  pRegistraAcao('Realizando o cadastro das Tintas...');

  intTotalReg := 0;

  Result := false;

  try
    try
      qryCadFar := fCriaQuery;

      qryCadFar.Close;
      qryCadFar.SQL.Text := 'TRUNCATE TABLE FAR_CADFAR;';
      qryCadFar.ExecSQL;


      qryArqBases := fCriaQuery;
      qryArqBases.Connection := fConnectionFdb;
      qryArqBases.SQL.Clear;
      qryArqBases.Close;
      qryArqBases.SQL.Text := ' SELECT * '+
                              '   FROM ARQPRO '+
                              '  WHERE ORIGEM <> ''MP''';
      qryArqBases.Open;

      try
        qryTotalReg := fCriaQuery;
        qryTotalReg.Connection := fConnectionFdb;
        qryTotalReg.SQL.Clear;
        qryTotalReg.Close;
        qryTotalReg.SQL.Text := ' SELECT COUNT(*) '+
                                '   FROM ARQPRO '+
                                '  WHERE ORIGEM <> ''MP''';
        qryTotalReg.Open;

        intTotalReg := qryTotalReg.fields[0].AsInteger;

      finally
        FreeAndNil(qryTotalReg);
      end;

      qryArqTintas := fCriaQuery;
      qryArqTintas.Connection := fConnectionFdb;

      intRegistro := 0;

      pRegistraProgresso(0,0,intTotalReg);

      qryArqBases.First;

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
        qryCadFar.SQL.Text := 'SELECT * '+
                              '  FROM FAR_CADFAR '+
                              ' WHERE FAR_CODNFM  =:CODNFM '+
                              '   AND FAR_TIPPRG = :TIPPRG ';
        qryCadFar.ParamByName('CODNFM').AsString := qryArqBases.FieldByName('CODIGO').AsString;
        qryCadFar.ParamByName('TIPPRG').AsString := qryArqBases.FieldByName('PRG').AsString;
        qryCadFar.Open;

        If Not (qryCadFar.IsEmpty) Then
        begin
          intFormQtd := 1;

          qryCadFar.Edit;

          While not (qryArqTintas.Eof)do
          begin

            If (qryArqTintas.FieldByName('DILUIDO').AsString = 'S') And fEmptyStr(qryCadFar.FieldByName('FAR_CODB' + fStrZero(intFormQtd, 2)).AsString) Then
              qryCadFar.FieldByName('FAR_CODB' + fStrZero(intFormQtd, 2)).AsString := qryArqTintas.FieldByName('CODMAT').AsString;

            if qryArqTintas.FieldByName('DILUIDO').AsString = 'S' then
            Begin
              qryCadFar.FieldByName('FAR_QTDD' + fStrZero(intFormQtd, 2)).AsFloat  := qryArqTintas.FieldByName('QUANT').AsFloat;
            End
            Else
            Begin
              qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intFormQtd, 2)).AsFloat  := qryArqTintas.FieldByName('QUANT').AsFloat;
            End;

            Inc(intFormQtd);

            qryArqTintas.Next;
          end;

          strMd5 := qryCadFar.FieldByName('FAR_MONTAD').AsString + qryCadFar.FieldByName('FAR_O_E_M_').AsString +
                    qryCadFar.FieldByName('FAR_A_N_O_').AsString + qryCadFar.FieldByName('FAR_DESCRI').AsString +
                    qryCadFar.FieldByName('FAR_SETOR_').AsString + qryCadFar.FieldByName('FAR_LINHA_').AsString +
                    qryCadFar.FieldByName('FAR_TIPPRG').AsString + qryCadFar.FieldByName('FAR_OBSERV').AsString;

          for intFormQtd := 1 to 20 do
          begin
            strMd5 := strMd5 + qryCadFar.FieldByName('FAR_CODB' + fStrZero(intFormQtd, 2)).AsString +
              StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDD' + fStrZero(intFormQtd, 2)).AsFloat), ',', '.', [rfReplaceAll]) +
              StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intFormQtd, 2)).AsFloat), ',', '.', [rfReplaceAll]);
          end;

          qryCadFar.FieldByName('FAR_MD5KEY').AsString := GetMD5(strMd5);

          qryCadFar.Post;
        end
        else
        begin
          qryCadFar.Insert;

          qryCadFar.FieldByName('AUTOINCREM').AsString := fFormataAutInc(qryArqBases.RecNo, VS_strCodEmp);
          qryCadFar.FieldByName('FAR_CODEMP').AsString := VS_strCodEmp;
          qryCadFar.FieldByName('FAR_CODSEQ').AsString := fStrZero(qryArqBases.RecNo, 6);
          qryCadFar.FieldByName('FAR_MONTAD').AsString := qryArqBases.FieldByName('MONTADORA').AsString;
          qryCadFar.FieldByName('FAR_O_E_M_').AsString := qryArqBases.FieldByName('OEM').AsString;
          qryCadFar.FieldByName('FAR_A_N_O_').AsString := qryArqBases.FieldByName('ANO').AsString;
          qryCadFar.FieldByName('FAR_DESCRI').AsString := qryArqBases.FieldByName('DESCRICAO').AsString;
          qryCadFar.FieldByName('FAR_SETOR_').AsString := qryArqBases.FieldByName('SETOR').AsString;
          qryCadFar.FieldByName('FAR_LINHA_').AsString := qryArqBases.FieldByName('LINHA').AsString;
          qryCadFar.FieldByName('FAR_CODNFM').AsString    := qryArqBases.FieldByName('CODIGO').AsString;
          qryCadFar.FieldByName('FAR_TIPPRG').AsString := qryArqBases.FieldByName('PRG').AsString;
          qryCadFar.FieldByName('FAR_OBSERV').AsString := qryArqBases.FieldByName('OBSFORM').AsString;

          intFormQtd := 1;

          While not (qryArqTintas.eof) do
          begin
            qryCadFar.FieldByName('FAR_CODB' + fStrZero(intFormQtd, 2)).AsString := qryArqTintas.FieldByName('CODMAT').AsString;

            if qryArqTintas.FieldByName('DILUIDO').AsString = 'S' then
            Begin
              qryCadFar.FieldByName('FAR_QTDD' + fStrZero(intFormQtd, 2)).AsFloat  := qryArqTintas.FieldByName('QUANT').AsFloat;
            End
            Else
            Begin
              qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intFormQtd, 2)).AsFloat  := qryArqTintas.FieldByName('QUANT').AsFloat;
            End;

            Inc(intFormQtd);

            qryArqTintas.Next;
          end;

          strMd5 := qryCadFar.FieldByName('FAR_MONTAD').AsString + qryCadFar.FieldByName('FAR_O_E_M_').AsString +
                    qryCadFar.FieldByName('FAR_A_N_O_').AsString + qryCadFar.FieldByName('FAR_DESCRI').AsString +
                    qryCadFar.FieldByName('FAR_SETOR_').AsString + qryCadFar.FieldByName('FAR_LINHA_').AsString +
                    qryCadFar.FieldByName('FAR_TIPPRG').AsString + qryCadFar.FieldByName('FAR_OBSERV').AsString;

          for intFormQtd := 1 to 20 do
          begin
            strMd5 := strMd5 + qryCadFar.FieldByName('FAR_CODB' + fStrZero(intFormQtd, 2)).AsString +
              StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDD' + fStrZero(intFormQtd, 2)).AsFloat), ',', '.', [rfReplaceAll]) +
              StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intFormQtd, 2)).AsFloat), ',', '.', [rfReplaceAll]);
          end;

          qryCadFar.FieldByName('FAR_MD5KEY').AsString := GetMD5(strMd5);

          qryCadFar.Post;
        end;

        Application.ProcessMessages;

        Inc(intRegistro);

        pRegistraProgresso(0,intRegistro,intTotalReg);

        if (FCancelarProcesso) then
        begin
          fRollback;
          Exit;
        end
        else
          qryArqBases.Next;
      end;

      if frmModulo.Database.InTransaction then
        fCommit;

      //******** Começando a calcular os concentrados para prg = 3

      pRegistraAcao('Aguarde, Localizando Basemix... ');

      //Query dos concentrados
      qryArqEprCon := fCriaQuery;
      qryArqEprCon.Connection := fConnectionFdb;

      //Achei todas as diluidas
      qryArqEprDil := fCriaQuery;
      qryArqEprDil.Connection := fConnectionFdb;
      qryArqEprDil.SQL.Clear;
      qryArqEprDil.Close;
      qryArqEprDil.SQL.Text := ' SELECT *               ' +
                               '   FROM ARQEPR E        ' +
                               '   JOIN ARQPRO P ON P.CODIGO = E.CODMAT ' +
                               '                AND P.PRG = E.PRG       ' +
                               '  WHERE E.DILUIDO = ''S''     ' +
                               '    AND P.PRG = ''3''         ' +
                               '    AND CODMAT <> ''UC700''   ' +
                               '    AND CODMAT <> ''UC800''   ' +
                               '  ORDER BY CODPRO             ';
      qryArqEprDil.Open;


      try
        qryTotalRegCalc := fCriaQuery;
        qryTotalRegCalc.Connection := fConnectionFdb;
        qryTotalRegCalc.SQL.Clear;
        qryTotalRegCalc.Close;
        qryTotalRegCalc.SQL.Text := ' SELECT COUNT(*)        ' +
                                    '   FROM ARQEPR E        ' +
                                    '   JOIN ARQPRO P ON P.CODIGO = E.CODMAT ' +
                                    '                AND P.PRG = E.PRG       ' +
                                    '  WHERE E.DILUIDO = ''S''     ' +
                                    '    AND P.PRG = ''3''         ' +
                                    '    AND CODMAT <> ''UC700''   ' +
                                    '    AND CODMAT <> ''UC800''   ';
        qryTotalRegCalc.Open;

        intTotalReg := qryTotalRegCalc.fields[0].AsInteger;
      finally
        FreeAndNil(qryTotalRegCalc);
      end;

      pRegistraAcao('Aguarde, Iniciando Atualização Basemix... ');

      pRegistraProgresso(0,0,intTotalReg);

//      pRegistraAcao('Aguarde, Erro aqui 1 ');

      intRegistro := 0;

      //Localizar iguais a de cima loop
      qryArqEprDil.First;
      While Not qryArqEprDil.Eof Do
      Begin
        strCodPro := qryArqEprDil.FieldByName('CODPRO').AsString;

//        pRegistraAcao('Aguarde, Erro aqui 2 ');
        If fEmptyStr(strCodProAnt) Or (strCodProAnt = strCodPro) Then
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT *       ';
          strSQL := strSQL + '   FROM ARQEPR  ';
          strSQL := strSQL + '  WHERE CODPRO  = :CODPRO    ';
          strSQL := strSQL + '    AND PRG     = ''2''      ';
          strSQL := strSQL + '    AND CODMAT  = :CODMAS    ';
          strSQL := strSQL + '    AND DILUIDO <> ''S''     ';

//          pRegistraAcao('Aguarde, Erro aqui 3 ');

          qryArqEprCon.Close;
          qryArqEprCon.SQL.Clear;
          qryArqEprCon.SQL.Text := strSQL;
          qryArqEprCon.ParamByName('CODPRO').AsString := qryArqEprDil.FieldByName('CODPRO').AsString;
          qryArqEprCon.ParamByName('CODMAS').AsString := qryArqEprDil.FieldByName('COD_MASTER').AsString;
          qryArqEprCon.Open;

//          pRegistraAcao('Aguarde, Erro aqui 4 ');

          //ClientDataSet com as formulas
          cdsDiluido.Append;
          cdsDiluido.FieldByName('CODPRO').AsString := qryArqEprDil.FieldByName('CODPRO').AsString;
          cdsDiluido.FieldByName('CODBAS').AsString := qryArqEprDil.FieldByName('CODMAT').AsString;
          cdsDiluido.FieldByName('FATOR').AsFloat   := ((qryArqEprCon.FieldByName('QUANT').AsFloat * 100) / qryArqEprDil.FieldByName('PER_COBERTURA').AsFloat);
          cdsDiluido.FieldByName('QTDBAS').AsFloat  := qryArqEprCon.FieldByName('QUANT').AsFloat;
          cdsDiluido.Post;

//          pRegistraAcao('Aguarde, Erro aqui 5 ');

          strCodProAnt := qryArqEprDil.FieldByName('CODPRO').AsString;
        End
        Else
        Begin
//          pRegistraAcao('Aguarde, Erro aqui 6 ');

          fltTotFat := 0;

          //codigo diferente entao tenho que somar resultado
          cdsDiluido.First;
          While Not cdsDiluido.Eof Do
          Begin
            fltTotFat := fltTotFat + cdsDiluido.FieldByName('FATOR').AsFloat;

            cdsDiluido.Next;
          End;

//          pRegistraAcao('Aguarde, Erro aqui 7 ');

          //pegar o fator de conversao de cada uma * 100 / total da soma

          cdsDiluido.First;
          While Not cdsDiluido.Eof Do
          Begin
            cdsDiluido.Edit;
            cdsDiluido.FieldByName('QTDCON').AsFloat := ((cdsDiluido.FieldByName('FATOR').AsFloat * 100) / fltTotFat);
            cdsDiluido.Post;

            cdsDiluido.Next;
          End;

//          pRegistraAcao('Aguarde, Erro aqui 8 ');

          //Verifica se existe o tipo 2, senao nao precisa calcular;
          qryCadFar.Close;
          qryCadFar.SQL.Clear;
          qryCadFar.SQL.Text := ' SELECT * ' +
                                '   FROM FAR_CADFAR ' +
                                '  WHERE FAR_CODNFM = :CODPRO ' +
                                '    AND FAR_TIPPRG = ''2'' ';

          qryCadFar.ParamByName('CODPRO').AsString := strCodProAnt;
          qryCadFar.Open;

          If Not qryCadFar.IsEmpty Then
          Begin
            //Encontrou o tipo 2 entao vai calcular o concentrado para o tipo 3
            qryCadFar.Close;
            qryCadFar.SQL.Clear;
            qryCadFar.SQL.Text := ' SELECT * ' +
                                  '   FROM FAR_CADFAR ' +
                                  '  WHERE FAR_CODNFM = :CODPRO ' +
                                  '    AND FAR_TIPPRG = ''3'' ' +
                                  '    AND (FAR_QTDC01 IS NULL OR FAR_QTDC01 = '''') ';

            qryCadFar.ParamByName('CODPRO').AsString := strCodProAnt;
            qryCadFar.Open;

//            pRegistraAcao('Aguarde, Erro aqui 9 ');

            intCont := 1;

            If Not qryCadFar.IsEmpty Then
            Begin
              Try
                //Adiciona na tabela da farben
                cdsDiluido.First;
                While Not cdsDiluido.Eof Do
                Begin
                  qryCadFar.Edit;
                  qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intCont,2)).AsFloat := cdsDiluido.FieldByName('QTDCON').AsFloat;
                  qryCadFar.Post;

                  intCont := intCont + 1;

//                  pRegistraAcao('Aguarde, Erro aqui 10 ');

                  cdsDiluido.Next;
                End;
              Except
                On E:Exception Do
                begin
                  pRegistraAcao(strCodProAnt);
                  pRegistraAcao(FloatToStr(qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intCont,2)).AsFloat));
                  pRegistraAcao(FloatToStr(cdsDiluido.FieldByName('QTDCON').AsFloat));
                  fMensagem('Atenção',E.Message,[]);
                end;
              End;
            End;
          End;

//          pRegistraAcao('Aguarde, Erro aqui 11 ');

          //Zerando cliente dataset
          cdsDiluido.EmptyDataSet;
          //Zerando variavel produto
          strCodProAnt := '';
          //Para recomeçar do proximo
          Continue;
        End;

        Application.ProcessMessages;

        Inc(intRegistro);

        pRegistraProgresso(0,intRegistro,intTotalReg);

        qryArqEprDil.Next;
      End;

      //********** Fim do calculo do concentrado prg = 3

      pRegistraAcao('Aguarde, finalizando o cadastro... ');

      farbenNfm := TFarbenAutomotivaNfm.Create(Nil);
      farbenNfm.fGravarNovasFormulas;

    except on  e : Exception do
      begin
        pRegistraAcao('Ocorreu erro ao processar o cadastro.');
        pRegistraProgresso(0,intTotalReg, intTotalReg);
        fRollBack;
      end;
    end;
  finally
    FreeAndNil(farbenNfm);

    FreeAndNil(qryArqBases);
    FreeAndNil(qryArqTintas);
    FreeAndNil(qryCadFar);

    FreeAndNil(qryArqEprCon);
    FreeAndNil(qryArqEprDil);
    FreeAndNil(cdsDiluido);

    pRegistraProgresso(0,intTotalReg, intTotalReg);

    if not (FCancelarProcesso) then
    begin
      pRegistraAcao('Tintas cadastradas com sucesso!');
      Result := True;
    end;

    if frmModulo.Database.InTransaction then
      fCommit;
  end;

end;

function TFarbenAutomotiva.fProcessarBases: Boolean;
var
  intProgresso : Integer;
  qryArquivo  : TUniQuery;
  qryTotalReg : TUniQuery;
  intTotalReg : Integer;

begin
  CancelarProcesso := False;

  qryArquivo := fCriaQuery;
  qryArquivo.Connection := fConnectionFdb;

  try
    qryArquivo.SQL.Clear;
    qryArquivo.Close;
    qryArquivo.SQL.Text := 'SELECT * FROM ARQPRO WHERE ORIGEM = ''MP''';
    qryArquivo.Open;

    intProgresso := 0;

    try
      qryTotalReg := fCriaQuery;
      qryTotalReg.Connection := fConnectionFdb;
      qryTotalReg.Close;
      qryTotalReg.SQL.Text := 'SELECT COUNT(*) FROM ARQPRO WHERE ORIGEM = ''MP''';
      qryTotalReg.Open;

      intTotalReg := qryTotalReg.fields[0].AsInteger;

    finally
      FreeAndNil(qryTotalReg);
    end;

    qryCadBas.Close;
    qryCadBas.SQL.Text := 'SELECT * FROM FAR_CADBAS;';
    qryCadBas.Open;

    qryArquivo.First;

    pRegistraAcao(' Cadastrando as bases...');

    pRegistraProgresso(0,0,intTotalReg);

    While Not(qryArquivo.Eof) Do
    Begin
      Try
        qryCadBas.Insert;
        qryCadBas.FieldByName('BAS_CODBAS').AsString := qryArquivo.FieldByName('CODIGO').AsString;
        qryCadBas.FieldByName('BAS_DESCRI').AsString := qryArquivo.FieldByName('DESCRICAO').AsString;
        qryCadBas.FieldByName('BAS_DENSID').AsFloat  := qryArquivo.FieldByName('DENSIDADE').AsFloat;
        qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := 3600.0000;
        qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FAR_CADBAS', VS_strCodEmp);
        qryCadBas.Post;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
          Begin
            qryCadBas.Cancel;
            fRollBack;
          End;
        End;
      End;

      Inc(intProgresso);

      pRegistraProgresso(0,intProgresso,intTotalReg);

      if FCancelarProcesso then
      begin
        Result := false;
        fRollBack;
        Exit;
      end;

      qryArquivo.Next;
    End;

  Finally
    FreeAndNil(qryArquivo);
  end;

  if frmModulo.Database.InTransaction then
    fCommit;

  Result := True;

  pRegistraProgresso(0,intTotalReg, intTotalReg);
  pRegistraAcao('Bases Cadastradas com Sucesso.');

end;

procedure TFarbenAutomotiva.pRegistraAcao(strAcao: String);
begin
  If Assigned(RegistraAcao) Then
    RegistraAcao(strAcao);
end;

procedure TFarbenAutomotiva.pRegistraProgresso(intInicio: Integer; intAtual: Integer; intFinal: Integer);
begin
  If Assigned(RegistraProgresso) Then
    RegistraProgresso(intInicio, intAtual, intFinal);
end;


function TFarbenAutomotiva.fCadBasVazia: Boolean;
begin
  qryCadBas.Close;
  qryCadBas.SQL.Text := 'SELECT * FROM FAR_CADBAS;';
  qryCadBas.Open;

  Result := qryCadBas.IsEmpty;

  If Result Then
    Exit;

  qryCadBas.Close;
  qryCadBas.SQL.Text := 'SELECT COUNT(BAS_CODITE) AS QTD FROM FAR_CADBAS;';
  qryCadBas.Open;

  Result := qryCadBas.FieldByName('QTD').AsInteger = 0;
end;

procedure TFarbenAutomotiva.pIniciaCadNfm;
begin
  qryCadNfm.Close;
  qryCadNfm.SQL.Text := 'SELECT * FROM FAR_CADNFM';
  qryCadNfm.Open;
  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

function fRetUltCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  try
    qryGen.Close;
    qryGen.SQL.Text := 'SELECT FAR_CODSEQ '+
                       '  FROM FAR_CADFAR '+
                       ' ORDER BY FAR_CODSEQ '+
                       '  DESC LIMIT 1;';
    qryGen.Open;

    If qryGen.IsEmpty Then
      Result := 1
    Else
      Result := qryGen.FieldByName('FAR_CODSEQ').AsInteger + 1;

   finally
     FreeAndNil(qryGen);
   end;
end;


constructor TFarbenAutomotivaNfm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  qryCadFar := fCriaQuery;

  qryCadFar.SQL.Text := 'SELECT * '+
                        '  FROM FAR_CADFAR '+
                        ' WHERE FALSE';
  qryCadFar.Open;
end;

destructor TFarbenAutomotivaNfm.Destroy;
begin
  If Assigned(qryCadFar) Then
    FreeAndNil(qryCadFar);
end;

function TFarbenAutomotivaNfm.fGravarNovasFormulas: Boolean;
  Var
    qryCadNfm    : TUniQuery;
    intProgresso : Integer;
    intTotal     : Integer;
begin
  qryCadNfm := fCriaQuery();

  try
    qryCadNfm.Close;
    qryCadNfm.SQL.Text := 'SELECT * FROM FAR_CADNFM';
    qryCadNfm.Open;

    pRegistraAcao('Cadastrando novas formulas...');

    intProgresso := 0;
    intTotal     := qryCadNfm.RecordCount;

    pRegistraProgresso(0,0,intTotal);

    qryCadNfm.First;

    While Not qryCadNfm.Eof Do
    Begin
      fGravarNovaFormula(qryCadNfm);
      qryCadNfm.Next;

      Inc(intProgresso);

      pRegistraProgresso(0, intProgresso, intTotal);

    End;

    pRegistraProgresso(0,intTotal, intTotal);

    pRegistraAcao('Cadastro de novas formulas realizada com sucesso!');

    Result := True;
  finally
    FreeAndNil(qryCadNfm);
  end;
end;


procedure pExcluirNfm(strCodigo: String);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(nil);

  try
    qryGen.Close;
    qryGen.SQL.Text := 'DELETE '+
                       '  FROM FAR_CADFAR '+
                       ' WHERE FAR_CODNFM = :CODNFM';
    qryGen.ParamByName('CODNFM').AsString := strCodigo;

    qryGen.ExecSQL;
  finally
    FreeAndNil(qryGen);
  end;
end;


class function TFarbenAutomotivaNfm.fGravarNovaFormula(qryCadNfm: TUniQuery): Boolean;
Var
  qryCadFar    : TUniQuery;
  intCont      : Integer;
  strMd5       : String;
begin

  qryCadFar := fCriaQuery();
  try
    qryCadFar.Close;
    qryCadFar.SQL.Text := 'SELECT * FROM FAR_CADFAR WHERE FALSE';
    qryCadFar.Open;

    pExcluirNfm(qryCadNfm.FieldByName('NFM_CODNFM').AsString);
    qryCadFar.Insert;
    qryCadFar.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FAR_CADFAR', VS_strCodEmp);
    qryCadFar.FieldByName('FAR_CODEMP').AsString := VS_strCodEmp;
    qryCadFar.FieldByName('FAR_CODSEQ').AsString := fStrZero(fRetUltCodSeq, 6);
    qryCadFar.FieldByName('FAR_MONTAD').AsString := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
    qryCadFar.FieldByName('FAR_O_E_M_').AsString := qryCadNfm.FieldByName('NFM_O_E_M_').AsString;
    qryCadFar.FieldByName('FAR_A_N_O_').AsString := qryCadNfm.FieldByName('NFM_A_N_O_').AsString;
    qryCadFar.FieldByName('FAR_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryCadFar.FieldByName('FAR_SETOR_').AsString := qryCadNfm.FieldByName('NFM_SETOR_').AsString;
    qryCadFar.FieldByName('FAR_LINHA_').AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
    qryCadFar.FieldByName('FAR_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
    qryCadFar.FieldByName('FAR_DTACAD').AsDateTime  := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

    For intCont := 1 To 20 Do
    Begin
      qryCadFar.FieldByName('FAR_CODB' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString;
      qryCadFar.FieldByName('FAR_QTDD' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_QTDD' + fStrZero(intCont, 2)).AsString;
      qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsString;
    End;

    qryCadFar.FieldByName('FAR_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;

    strMd5 := qryCadFar.FieldByName('FAR_MONTAD').AsString + qryCadFar.FieldByName('FAR_O_E_M_').AsString +
              qryCadFar.FieldByName('FAR_A_N_O_').AsString + qryCadFar.FieldByName('FAR_DESCRI').AsString +
              qryCadFar.FieldByName('FAR_SETOR_').AsString + qryCadFar.FieldByName('FAR_LINHA_').AsString;

    for intCont := 1 to 20 do
    begin
      strMd5 := strMd5 + qryCadFar.FieldByName('FAR_CODB' + fStrZero(intCont, 2)).AsString +
        StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDD' + fStrZero(intCont, 2)).AsFloat), ',', '.', [rfReplaceAll]) +
        StringReplace(FormatFloat('0.00000', qryCadFar.FieldByName('FAR_QTDC' + fStrZero(intCont, 2)).AsFloat), ',', '.', [rfReplaceAll]);
    end;

    qryCadFar.FieldByName('FAR_MD5KEY').AsString := GetMD5(strMd5);

    qryCadFar.Post;

    Result := True;

   Finally
     FreeAndNil(qryCadFar);
   end;

end;

end.
