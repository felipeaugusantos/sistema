{*************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta AnjoImobiliaria *}
{**********************************************************************PH*}
unit untGravandoExecucaoAnjoImobiliariaCores;

interface

uses
  untAbstractGravandoExecucaoAnjoImobiliaria, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils,
  uni, ComObj, DBFUniProvider;

  type
    TGravandoExecucaoAnjoImobiliariaCores = class(TAbstractGravandoExecucaoAnjoImobiliaria)
  private
    PlanilhaFrm     : OleVariant;
    SheetFrm        : OleVariant;
    intUltLinhaFrm  : Integer;
    intLinhaProgFrm : Integer;
    intLinhaFrm     : Integer;

    function fRetPatDBF : String;
    function fRetPatDBF2 : String;
    function fCalQtdEmb(fltQtdCol: Double; strEmbCon, strQtdEmb: String): Double;
    function fQtdRegistros(strCamId: String): Integer;
    function fRetCodEmb(intContador: Integer; intRegistros: Integer): String;
    function fRetUnidade(strCodEmb: String): String;
    procedure IsDeletarRegistros(Gravando: IGravando);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;const stlTabelas: TStrings): string; override;
  end;

implementation

{ TGravandoExecucaoAnjoImobiliariaCores }

uses untStrUtils, untFuncoesGenerica;

procedure TGravandoExecucaoAnjoImobiliariaCores.Executar(const gravando: IGravando);
var
  qryDestino : IDataSet;
  qryBaseDbf : TUniQuery;
  DataBases  : TUniConnection;

  PlanilhaProd     : OleVariant;
  SheetProd        : OleVariant;
  intUltLinhaProd  : Integer;
  intLinhaProd     : Integer;

  PlanilhaSub     : OleVariant;
  SheetSub        : OleVariant;
  intUltLinhaSub  : Integer;
  intLinhaSub     : Integer;

  strPatPro : String;
  strProKey : String;

  strPatSub : String;
  strSubKey : String;

  strBaseSe : String;
  strDesTin : String;
  strEmbCom : String;
  strQtdEmb : String;
  strCamId_ : String;

  intPatAnjo : Integer;
  strPath    : String;

  intPos     : Integer;
  intCodSeq  : Integer;
  intColora  : Integer;
  strFormula : String;

  intCont   : Integer;
  strMd5    : String;
  qryCadAnj : IDataSet;
  qryCadBas : IDataSet;
  fltQuantidade : double;

  intAutoincrem : Integer;
  slQuebraLinha : TStringList;
  slColorantes  : TStringList;
  slQuantidades : TStringList;

  intQuebraLinha : Integer;
  intColorantes  : Integer;
  intQuantidades : Integer;
  intQtdRegistro : Integer;
  intContador: Integer;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not DirectoryExists(fRetPatDBF)) Then
      Begin
        gravando.Texto := 'Path para o geração do arquivo de cores não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';

      gravando.Texto := 'Carregando dados...';

      IsDeletarRegistros(Gravando);


      strPath := fRetPatDBF;

      For intPatAnjo := 1 to 2 do
      Begin
        If intPatAnjo = 2 Then
        Begin
          if ((strPath = EmptyStr) Or (fRetPatDBF2 = EmptyStr)) then
            Exit
          else
            strPath := fRetPatDBF2;
        End;

        PlanilhaProd := CreateOleObject('Excel.Application');
        PlanilhaProd.WorkBooks.open(strPath + '\PRODUCTS.DBF');

        DataBases := TUniConnection.Create(Nil);
        DataBases.ProviderName := 'DBF';
        DataBases.LoginPrompt  := False;

        DataBases.Database     := strPath;

        If (Not DataBases.Connected) Then
          DataBases.Connected := True;

        qryBaseDbf := TUniQuery.Create(Nil);
        qryBaseDbf.Connection := DataBases;

        qryBaseDbf.Close;
        qryBaseDbf.SQL.Clear;
        qryBaseDbf.SQL.Add(' SELECT * FROM \BASES.DBF');
        qryBaseDbf.Open;


        gravando.Texto := 'Dados carregados com sucesso!';

        gravando.Texto := 'Verificando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('ANJ_CADBAS');
        gravando.Texto := 'PROCOD verificado com sucesso!';

        SheetProd := PlanilhaProd.Workbooks[1].WorkSheets['PRODUCTS'];

        intUltLinhaProd := SheetProd.Cells.SpecialCells(11).Row;

        intLinhaProd     := 2;

        intCodSeq := 0;

        slQuebraLinha := TStringList.Create;

        slQuebraLinha.Delimiter := ',';
        slQuebraLinha.StrictDelimiter := True;

        slColorantes  := TStringList.Create;
        slQuantidades := TStringList.Create;

        While (intLinhaProd <= intUltLinhaProd) Do
        begin
          Try
            Try
              if gravando.Status <> sgGravando then
                Exit;

              strPatPro := strPath + '\' + SheetProd.cells[intLinhaProd, 4].Text;
              strProKey := TStrUtils.fStrZero(Trim(SheetProd.cells[intLinhaProd, 1].Text), 2);

              PlanilhaSub := CreateOleObject('Excel.Application');
              PlanilhaSub.WorkBooks.open(strPatPro + '\SUBPRODS.DBF');

              SheetSub := PlanilhaSub.Workbooks[1].WorkSheets['SUBPRODS'];

              intUltLinhaSub := SheetSub.Cells.SpecialCells(11).Row;

              intLinhaSub     := 2;

              Try
                While (intLinhaSub <= intUltLinhaSub) Do
                begin
                  strPatSub := strPatPro + '\' + SheetSub.cells[intLinhaSub, 4].Text;
                  strSubKey := TStrUtils.fStrZero(Trim(SheetSub.cells[intLinhaSub, 1].Text), 2);

                  PlanilhaFrm := CreateOleObject('Excel.Application');

                  If FileExists(strPatSub + '\FRM.DBF') Then
                    PlanilhaFrm.WorkBooks.open(strPatSub + '\FRM.DBF')
                  Else If FileExists(strPatPro + '\frm.dbf') Then
                    PlanilhaFrm.WorkBooks.open(strPatPro + '\FRM.DBF')
                  Else
                    PlanilhaFrm.WorkBooks.open(strPath + '\FRM.DBF');


                  SheetFrm := PlanilhaFrm.Workbooks[1].WorkSheets['FRM'];

                  intUltLinhaFrm := SheetFrm.Cells.SpecialCells(11).Row;

                  gravando.Texto := 'Carregando os registros do arquivo ' + strPatPro + '\FRM.DBF';

                  intLinhaFrm     := 2;
                  intLinhaProgFrm := 1;

                  Try
                    While (intLinhaFrm <= intUltLinhaFrm) Do
                    Begin
                      strCamId_ := TStrUtils.fStrZero(Trim(SheetFrm.Cells[intLinhaFrm, 8].Text), 2);

                      intQtdRegistro := fQtdRegistros(strCamId_);

                      For intContador := 1 To intQtdRegistro Do
                      Begin
                        strBaseSe  := TStrUtils.fStrZero(Trim(SheetFrm.cells[intLinhaFrm, 7].Text), 2);
                        strEmbCom  := TStrUtils.fStrZero(Trim(SheetFrm.cells[intLinhaFrm, 8].Text), 2);
                        strFormula := SheetFrm.cells[intLinhaFrm, 10].Text;
                        strQtdEmb  := fRetCodEmb(intContador, intQtdRegistro);


                        slQuebraLinha.DelimitedText := strFormula;

                        slColorantes.Clear;
                        slQuantidades.Clear;

                        for intQuebraLinha := 0 To slQuebraLinha.Count - 1 Do
                        Begin
                          If (intQuebraLinha mod 2 = 0) Then
                          Begin
                            slColorantes.Add(slQuebraLinha[intQuebraLinha]);
                          End
                          else
                          Begin
                            fltQuantidade := StrToFloat(StringReplace(slQuebraLinha[intQuebraLinha],'.',',',[]));

                            slQuantidades.Add(FloatToStr(fCalQtdEmb(fltQuantidade, strEmbCom, strQtdEmb)));
                          End;
                        End;

                        qryBaseDbf.Locate('ID', SheetFrm.cells[intLinhaFrm, 7].Text, []);

                        strDesTin := AnsiUpperCase( Trim(SheetFrm.cells[intLinhafrm, 2].Text) + ' ' +
                                                    Trim(SheetSub.cells[intLinhaSub, 3].Text) + ' ' +
                                                    Trim(SheetFrm.cells[intLinhafrm, 4].Text)
                                                  );

                       If Not Assigned(qryCadBas) Then
                          qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;

                        qryCadBas.Close;
                        qryCadBas.SQL := 'SELECT * '+
                                         '  FROM ANJ_CADBAS '+
                                         ' WHERE BAS_BASE__ = :BASE__ '+
                                         '   AND BAS_PROKEY = :PROKEY '+
                                         '   AND BAS_SUBKEY = :SUBKEY '+
                                         '   AND BAS_UNIDAD = :UNIDAD ';
                        qryCadBas.ParamByName('BASE__').AsString := strBaseSe;
                        qryCadBas.ParamByName('PROKEY').AsString := strProKey;
                        qryCadBas.ParamByName('SUBKEY').AsString := strSubKey;
                        qryCadBas.ParamByName('UNIDAD').AsString := fRetUnidade(strQtdEmb);
                        qryCadBas.Open;

                        If Not(qryCadBas.IsEmpty) Then
                        Begin
                          If Not Assigned(qryCadAnj) Then
                            qryCadAnj := TAutcomTintaFactory.Get.fGetDataSet;

                          qryCadAnj.Close;
                          qryCadAnj.SQL := 'SELECT *          '+
                                           '  FROM ANJ_CADANJ '+
                                           ' WHERE ANJ_DESCRI =:DESCRI '+
                                           '   AND ANJ_CODIGO =:CODIGO '+
                                           '   AND ANJ_CODIG2 =:CODIG2 '+
                                           '   AND ANJ_UNIDAD =:UNIDAD '+
                                           '   AND ANJ_PROKEY =:PROKEY '+
                                           '   AND ANJ_SUBKEY =:SUBKEY '+
                                           '   AND ANJ_BASE__ =:BASE__ ';

                          qryCadAnj.ParamByName('DESCRI').AsString := strDesTin;
                          qryCadAnj.ParamByName('CODIGO').AsString := AnsiUpperCase(SheetFrm.cells[intLinhaFrm, 2].Text);
                          qryCadAnj.ParamByName('CODIG2').AsString := SheetFrm.cells[intLinhaFrm, 4].Text;
                          qryCadAnj.ParamByName('UNIDAD').AsString := fRetUnidade(strQtdEmb);
                          qryCadAnj.ParamByName('PROKEY').AsString := qryCadBas.FieldByName('BAS_PROKEY').AsString;
                          qryCadAnj.ParamByName('SUBKEY').AsString := qryCadBas.FieldByName('BAS_SUBKEY').AsString;
                          qryCadAnj.ParamByName('BASE__').AsString := qryCadBas.FieldByName('BAS_BASE__').AsString;
                          qryCadAnj.Open;

                          If (qryCadAnj.IsEmpty) Then
                          Begin
                            qryCadAnj.Insert;
                            qryCadAnj.FieldByName('ANJ_CODSEQ').AsString := TStrUtils.fStrZero(intCodSeq, 6);
                            qryCadAnj.FieldByName('ANJ_DESCRI').AsString := strDesTin;
                            qryCadAnj.FieldByName('ANJ_CODIGO').AsString := AnsiUpperCase(SheetFrm.cells[intLinhaFrm, 2].Text);
                            qryCadAnj.FieldByName('ANJ_CODIG2').AsString := AnsiUpperCase(SheetFrm.cells[intLinhaFrm, 4].Text);
                            qryCadAnj.FieldByName('ANJ_UNIDAD').AsString := fRetUnidade(strQtdEmb);
                            qryCadAnj.FieldByName('ANJ_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
                            qryCadAnj.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ANJ_CADANJ', TAutcomTintaFactory.Get.GetCodEmp);
                            qryCadAnj.FieldByName('ANJ_BASE__').AsString := qryCadBas.FieldByName('BAS_BASE__').AsString;
                            qryCadAnj.FieldByName('ANJ_PROKEY').AsString := qryCadBas.FieldByName('BAS_PROKEY').AsString;
                            qryCadAnj.FieldByName('ANJ_SUBKEY').AsString := qryCadBas.FieldByName('BAS_SUBKEY').AsString;
                            //
                            strMd5 := strMd5 + qryCadAnj.FieldByName('ANJ_DESCRI').AsString;
                            strMd5 := strMd5 + qryCadAnj.FieldByName('ANJ_CODIGO').AsString;
                            strMd5 := strMd5 + qryCadAnj.FieldByName('ANJ_CODIG2').AsString;
                            strMd5 := strMd5 + qryCadAnj.FieldByName('ANJ_UNIDAD').AsString;
                            strMd5 := strMd5 + qryCadAnj.FieldByName('ANJ_PROKEY').AsString;
                            strMd5 := strMd5 + qryCadAnj.FieldByName('ANJ_SUBKEY').AsString;
                            strMd5 := strMd5 + qryCadAnj.FieldByName('ANJ_BASE__').AsString;


                            For intColorantes := 0 To slColorantes.Count - 1 Do
                            Begin
                              qryCadAnj.FieldByName('ANJ_FORM' + TStrUtils.fStrZero(intColorantes + 1, 2)).AsString := slColorantes[intColorantes];
                              qryCadAnj.FieldByName('ANJ_QTDB' + TStrUtils.fStrZero(intColorantes + 1, 2)).AsFloat := TAutcomTintaFactory.Get.fStrToFloat(slQuantidades[intColorantes]);

                              strMd5 := strMd5 + slColorantes[intColorantes] + slQuantidades[intColorantes];
                            End;

                            strMd5 := GetMD5(strMd5);

                            qryCadAnj.FieldByName('ANJ_MD5KEY').AsString := strMd5;

                            qryCadAnj.Post;

                            Inc(intCodSeq);
                          End;
                        End;
                      End;
                      gravando.RegistrarProgresso(0, intLinhaProgFrm, intUltLinhaFrm);

                      Inc(intLinhaFrm);
                      Inc(intLinhaProgFrm);

                    End;
                  Finally
                    gravando.RegistrarProgresso(0, intLinhaProgFrm, intUltLinhaFrm);
                    PlanilhaFrm.WorkBooks.Close;
                  End;

                  Inc(intLinhaSub);
                End;
              Finally
                PlanilhaSub.WorkBooks.Close;
              End;

              Inc(intLinhaProd);

            Except
              on E: Exception do
              begin
                gravando.Cancelar;
                gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
              end;
            End;
          Finally
           // gravando.RegistrarProgresso(0, intLinhaProgProd, intUltLinhaProd);
          End;
        end;
      End;


      If Assigned(slColorantes)  Then FreeAndNil(slColorantes);
      If Assigned(slQuantidades) Then FreeAndNil(slQuantidades);
      If Assigned(slQuebraLinha) Then FreeAndNil(slQuebraLinha);

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    PlanilhaProd.WorkBooks.Close;
  End;
end;

function TGravandoExecucaoAnjoImobiliariaCores.fCalQtdEmb(fltQtdCol: Double;strEmbCon, strQtdEmb: String): Double;
Var
  fltEmbAtu : Double;
  fltEmbMas : Double;
  qryAux    : IDataSet;
begin

  qryAux:= TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := 'SELECT * '+
                    '  FROM ANJ_CADEMB '+
                    ' WHERE EMB_USAEMB = "S"';
  qryAux.Open;

  qryAux.Locate('EMB_CODEMB', strEmbCon, []);
  fltEmbAtu := qryAux.FieldByName('EMB_QTDEMB').AsFloat;

  qryAux.Locate('EMB_CODEMB', strQtdEmb, []);
  fltEmbMas := qryAux.FieldByName('EMB_QTDEMB').AsFloat;

  Result := (fltEmbMas * fltQtdCol) ;
  Result := (Result / fltEmbAtu)
end;

function TGravandoExecucaoAnjoImobiliariaCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TGravandoExecucaoAnjoImobiliariaCores.fQtdRegistros(
  strCamId: String): Integer;
begin
  Result := 0;

  If strCamId = '01' Then
    Result := 3  //LT,GL,LA
  Else If strCamId = '02' Then
    Result := 2 //GL, LA
  Else If strCamId = '03' Then
    Result := 1; //LA
end;

function TGravandoExecucaoAnjoImobiliariaCores.fRetPatDBF: String;
begin
  Result := conf.fGet('PATANJ'); //ANJO1
end;

function TGravandoExecucaoAnjoImobiliariaCores.fRetPatDBF2: String;
begin
  Result := conf.fGet('ANJPAT');
end;

function TGravandoExecucaoAnjoImobiliariaCores.fRetUnidade(
  strCodEmb: String): String;
begin
  Result := 'LT';

  If strCodEmb = '01' Then
    Result := 'LT'
  Else If strCodEmb = '02' Then
    Result := 'GL'
  Else If strCodEmb = '03' Then
    Result := 'LA';
end;

function TGravandoExecucaoAnjoImobiliariaCores.fRetCodEmb(intContador,
  intRegistros: Integer): String;
begin
  Result := '';

  If intRegistros = 3 Then
  Begin
    If intContador = 1 Then
      Result := '01'
    Else If intContador = 2 Then
      Result := '02'
    Else If intContador = 3 Then
      Result := '03';
  End
  Else If intRegistros = 2 Then
  Begin
    If intContador = 1 Then
      Result := '02'
    Else If intContador = 2 Then
      Result := '03';
  End
  Else If intRegistros = 1 Then
    Result := '03';
end;

function TGravandoExecucaoAnjoImobiliariaCores.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM ANJ_CADBAS';
end;

function TGravandoExecucaoAnjoImobiliariaCores.GetSqlOrigem(
  const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result := '';
end;

procedure TGravandoExecucaoAnjoImobiliariaCores.IsDeletarRegistros(
  Gravando: IGravando);
Var
  qryGen: IDataSet;
begin
  Try
    Gravando.Texto := 'Deletando Registros da tabela ANJ_CADANJ...';

    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := '   DELETE FROM ANJ_CADANJ    ';
    qryGen.ExecSQL;
  Except
    Raise;
  End;
end;

end.
