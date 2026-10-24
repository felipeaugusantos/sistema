{******************************************************************************}
{* Classe responsável pela geração do cadastro de Cores da tinta SherwinWilliams 2*}
{***************************************************************************PH*}
unit untGravandoExecucaoSherwinWilliams2Cores;

interface

uses
  untAbstractGravandoExecucaoSherwinWilliams2, untIGravando, SysUtils, untIDataSet,System.Classes,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  Variants, UniClientDataSet, Uni, DB, Windows, Vcl.Graphics;
type
  TGravandoExecucaoSherwinWilliams2Cores = class(TAbstractGravandoExecucaoSherwinWilliams2)
  private
    cdsRgbFamily: TUniClientDataSet;
    procedure pCarregarRgbFamilia(const Gravando: IGravando);
    procedure DeletarFormulaQtdMin(cdsDados: IDataSet);
    function fRGBToTColor(R, G, B: Byte): TColor;
    function fTColorToHex(AColor: TColor): String;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function fRetCodUni(strValor : String) : String;

  end;

implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoSherwinWilliams2Cores}

procedure TGravandoExecucaoSherwinWilliams2Cores.DeletarFormulaQtdMin(
  cdsDados: IDataSet);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL +  ' SELECT *          ';
  qryGen.SQL := qryGen.SQL +  '   FROM  SHW_CADSHW      ';
  qryGen.SQL := qryGen.SQL +  ' WHERE             ';
  qryGen.SQL := qryGen.SQL +  '   SHW_BASE__ = :BASE  AND       ';
  qryGen.SQL := qryGen.SQL +  '   SHW_CODUNI = :UNID  AND       ';
  qryGen.SQL := qryGen.SQL +  '   SHW_CODIGO = :CODI  AND       ';
  qryGen.SQL := qryGen.SQL +  '   SHW_PRODUT = :PROD            ';

  qryGen.ParamByName('BASE').AsString := cdsDados.FieldByName('BASE').AsString;
  qryGen.ParamByName('UNID').AsString := fRetCodUni(cdsDados.FieldByName('EMBALAGEM').AsString);
  qryGen.ParamByName('CODI').AsString := cdsDados.FieldByName('COD_COR').AsString;
  qryGen.ParamByName('PROD').AsString := cdsDados.FieldByName('PRODUTO').AsString;
  qryGen.Open;

  If qryGen.IsEmpty Then
    Exit;

  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL +  '  DELETE                ';
  qryGen.SQL := qryGen.SQL +  '    FROM SHW_CADSHW            ';
  qryGen.SQL := qryGen.SQL +  '  WHERE                 ';
  qryGen.SQL := qryGen.SQL +  '    SHW_BASE__ = :BASE AND     ';
  qryGen.SQL := qryGen.SQL +  '    SHW_CODUNI = :UNID AND     ';
  qryGen.SQL := qryGen.SQL +  '    SHW_CODIGO = :CODI AND     ';
  qryGen.SQL := qryGen.SQL +  '    SHW_PRODUT = :PROD         ';

  qryGen.ParamByName('BASE').AsString := cdsDados.FieldByName('BASE').AsString;
  qryGen.ParamByName('UNID').AsString := fRetCodUni(cdsDados.FieldByName('EMBALAGEM').AsString);
  qryGen.ParamByName('CODI').AsString := cdsDados.FieldByName('COD_COR').AsString;
  qryGen.ParamByName('PROD').AsString := cdsDados.FieldByName('PRODUTO').AsString;
  qryGen.ExecSQL;
end;

procedure TGravandoExecucaoSherwinWilliams2Cores.Executar(const gravando: IGravando);
var
  qryCadCor    : IDataSet;
  qryDelCor    : IDataSet;
  cdsDados     : IDataSet;
  intColorante : Integer;
  fltMinVol    : Double;
  strBasAnt, strCodAnt,
  strProAnt, strUniAnt: String;
  AColor: TColor;
begin
  Try
    Try

      fltMinVol := 0.0739;

      pCarregarRgbFamilia(Gravando);

      CarregarDados(gravando);
      qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SHW_CADSHW');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Apagando os registros da tabela SHW_CADSHW...';
      qryDelCor := TAutcomTintaFactory.Get.fGetDataSet;
      qryDelCor.SQL := 'DELETE FROM SHW_CADSHW';
      qryDelCor.ExecSQL;
      gravando.Texto := 'Registros apagados com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Cores...';

      cdsDados := TAutcomTintaFactory.Get.fGetDataSet;
      cdsDados.SQL := 'SELECT * FROM TMP_CORES_SHW';
      cdsDados.Open;

      cdsDados.First;

      intColorante := 0;

      While Not cdsDados.Eof Do
      Begin
        If gravando.Status <> sgGravando Then
          Exit;

        If StrToFloat(StringReplace(cdsDados.FieldByName('MLS').AsString,'.',',',[])) < fltMinVol Then
        Begin
          DeletarFormulaQtdMin(cdsDados);
          strBasAnt := cdsDados.FieldByName('BASE').AsString;
          strCodAnt := cdsDados.FieldByName('COD_COR').AsString;
          strUniAnt := fRetCodUni(cdsDados.FieldByName('EMBALAGEM').AsString);
          strProAnt := cdsDados.FieldByName('PRODUTO').AsString;
          cdsDados.Next;
          Continue;
        End;

        If (cdsDados.FieldByName('BASE').AsString = strBasAnt) And (fRetCodUni(cdsDados.FieldByName('EMBALAGEM').AsString) = strUniAnt) And
          (cdsDados.FieldByName('COD_COR').AsString = strCodAnt) And (cdsDados.FieldByName('PRODUTO').AsString = strProAnt) Then
        Begin
          cdsDados.Next;
          Continue;
        End;

        If Not Assigned(qryCadCor) Then
          qryCadCor := TAutcomTintaFactory.Get.fGetDataSet;

        qryCadCor.Close;
        qryCadCor.SQL := 'SELECT * '+
                         '  FROM SHW_CADSHW '+
                         ' WHERE SHW_BASE__ = :CODBAS '+
                         '   AND SHW_CODUNI = :CODUNI '+
                         '   AND SHW_CODIGO = :CODIGO '+
                         '   AND SHW_PRODUT = :PRODUT ';


        qryCadCor.ParamByName('CODBAS').AsString := cdsDados.FieldByName('BASE').AsString;
        qryCadCor.ParamByName('CODUNI').AsString := fRetCodUni(cdsDados.FieldByName('EMBALAGEM').AsString);
        qryCadCor.ParamByName('CODIGO').AsString := cdsDados.FieldByName('COD_COR').AsString;
        qryCadCor.ParamByName('PRODUT').AsString := cdsDados.FieldByName('PRODUTO').AsString;
        qryCadCor.Open;

        If (qryCadCor.IsEmpty) Then
        Begin

          intColorante := 1;



          qryCadCor.Insert;
          qryCadCor.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SHW_CADSHW', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCor.FieldByName('SHW_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCor.FieldByName('SHW_ATIVAD').AsString := 'S';
          qryCadCor.FieldByName('SHW_DTACAD').AsDate   := Date;
          qryCadCor.FieldByName('SHW_CODIGO').AsString := cdsDados.FieldByName('COD_COR').AsString ;
          qryCadCor.FieldByName('SHW_DESCRI').AsString := cdsDados.FieldByName('NOME_COR').AsString;
          qryCadCor.FieldByName('SHW_PRODUT').AsString := cdsDados.FieldByName('PRODUTO').AsString;
          qryCadCor.FieldByName('SHW_BASE__').AsString := cdsDados.FieldByName('BASE').AsString;
          qryCadCor.FieldByName('SHW_CODUNI').AsString := fRetCodUni(cdsDados.FieldByName('EMBALAGEM').AsString);
          qryCadCor.FieldByName('SHW_OBSERV').AsString := cdsDados.FieldByName('OBSERVACAO').AsString;
          qryCadCor.FieldByName('SHW_FORM01').AsString := cdsDados.FieldByName('CORANTE').AsString;
          qryCadCor.FieldByName('SHW_QTDC01').AsFloat  := StrToFloat(StringReplace(cdsDados.FieldByName('MLS').AsString,'.',',',[]));

          If cdsRgbFamily.Locate('CODIGO;NOME_COR', VarArrayOf([cdsDados.FieldByName('COD_COR').AsString, cdsDados.FieldByName('NOME_COR').AsString]), []) Then
          Begin
            qryCadCor.FieldByName('SHW_RED___').AsString := cdsRgbFamily.FieldByName('R').AsString;
            qryCadCor.FieldByName('SHW_GREEN_').AsString := cdsRgbFamily.FieldByName('G').AsString;
            qryCadCor.FieldByName('SHW_BLUE__').AsString := cdsRgbFamily.FieldByName('B').AsString;
            qryCadCor.FieldByName('SHW_FAMILI').AsString := cdsRgbFamily.FieldByName('FAMILIA').AsString;

            AColor := fRGBToTColor(cdsRgbFamily.FieldByName('R').AsInteger, cdsRgbFamily.FieldByName('G').AsInteger, cdsRgbFamily.FieldByName('B').AsInteger);

            qryCadCor.FieldByName('SHW_R_G_B_').AsString := fTColorToHex(AColor);
          End;

          qryCadCor.FieldByName('SHW_MD5KEY').AsString := GetMD5(qryCadCor.FieldByName('SHW_CODIGO').AsString +
                                                                 qryCadCor.FieldByName('SHW_DESCRI').AsString +
                                                                 qryCadCor.FieldByName('SHW_PRODUT').AsString +
                                                                 qryCadCor.FieldByName('SHW_BASE__').AsString +
                                                                 qryCadCor.FieldByName('SHW_CODUNI').AsString);

          qryCadCor.Post;
        End
        else
        begin
          Inc(intColorante);

          If intColorante > 20 Then
          Begin
            cdsDados.Next;
            Continue;
          End;

          qryCadCor.Edit;
          qryCadCor.FieldByName('SHW_FORM'+ TStrUtils.fStrZero(IntToStr(intColorante), 2)).AsString := cdsDados.FieldByName('CORANTE').AsString;
          qryCadCor.FieldByName('SHW_QTDC'+ TStrUtils.fStrZero(IntToStr(intColorante), 2)).AsFloat  := StrToFloat(StringReplace(cdsDados.FieldByName('MLS').AsString,'.',',',[]));
          qryCadCor.Post;
        end;

        gravando.RegistrarProgresso(0, cdsDados.RecNo, cdsDados.RecordCount);
        cdsDados.Next;
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

function TGravandoExecucaoSherwinWilliams2Cores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;


function TGravandoExecucaoSherwinWilliams2Cores.fRetCodUni(strValor: String): String;
begin
  Result := 'QT';

  If strValor = 'QUARTO' Then
    Result := 'QT'
  Else
  If strValor = 'GALAO' Then
    Result := 'GL'
  Else If (strValor = 'LATA') Or (strValor = '14LTS.') Or (strValor = '12.5LTS.') Then
    Result := 'LA';
end;

function TGravandoExecucaoSherwinWilliams2Cores.fRGBToTColor(R, G,
  B: Byte): TColor;
begin
  Result := RGB(R, G, B);
end;

function TGravandoExecucaoSherwinWilliams2Cores.fTColorToHex(
  AColor: TColor): String;
var
  R, G, B: Byte;
begin
  R := GetRValue(AColor);
  G := GetGValue(AColor);
  B := GetBValue(AColor);

  Result := IntToHex(R, 2) + IntToHex(G, 2) + IntToHex(B, 2);
end;

procedure TGravandoExecucaoSherwinWilliams2Cores.pCarregarRgbFamilia(const Gravando: IGravando);
Var
  Excel: Variant;
  ExcelRgb: Variant;
  RecordCount: Integer;
  RecNo: Integer;
begin

  Gravando.Texto := 'Verificando Path [RGB & FAMILIA]...';

  If Not FileExists(Conf.fGet('PATRGB')) Then
  Begin
    Gravando.Texto := Format('O arquivo [%s] não foi encontrado! Verifique as Configurações.', [AnsiReplaceStr(Conf.fGet('PATRGB'), '"', '')]);
    Exit;
  End;

  Gravando.Texto := 'Path Verificado com sucesso...';


  Gravando.Texto := 'Processando Rgbs e Familia das Cores...';

  cdsRgbFamily := TUniClientDataSet.Create(Nil);

  cdsRgbFamily.FieldDefs.AddFieldDef;
  cdsRgbFamily.FieldDefs[0].DataType := ftString;
  cdsRgbFamily.FieldDefs[0].Name := 'CODIGO';
  cdsRgbFamily.FieldDefs[0].Size := 10;

  cdsRgbFamily.FieldDefs.AddFieldDef;
  cdsRgbFamily.FieldDefs[1].DataType := ftString;
  cdsRgbFamily.FieldDefs[1].Name := 'NOME_COR';
  cdsRgbFamily.FieldDefs[1].Size := 50;

  cdsRgbFamily.FieldDefs.AddFieldDef;
  cdsRgbFamily.FieldDefs[2].DataType := ftString;
  cdsRgbFamily.FieldDefs[2].Name := 'R';
  cdsRgbFamily.FieldDefs[2].Size := 3;

  cdsRgbFamily.FieldDefs.AddFieldDef;
  cdsRgbFamily.FieldDefs[3].DataType := ftString;
  cdsRgbFamily.FieldDefs[3].Name := 'G';
  cdsRgbFamily.FieldDefs[3].Size := 3;

  cdsRgbFamily.FieldDefs.AddFieldDef;
  cdsRgbFamily.FieldDefs[4].DataType := ftString;
  cdsRgbFamily.FieldDefs[4].Name := 'B';
  cdsRgbFamily.FieldDefs[4].Size := 3;

  cdsRgbFamily.FieldDefs.AddFieldDef;
  cdsRgbFamily.FieldDefs[5].DataType := ftString;
  cdsRgbFamily.FieldDefs[5].Name := 'FAMILIA';
  cdsRgbFamily.FieldDefs[5].Size := 30;

  cdsRgbFamily.CreateDataSet();

  ExcelRgb := CreateOleObject('Excel.Application');
  ExcelRgb.Visible := False;
  ExcelRgb.WorkBooks.Open(Conf.fGet('PATRGB'));
  Excel := ExcelRgb.WorkBooks[1].WorkSheets[1];
  RecordCount := Excel.Cells.SpecialCells(11).Row;

  Try
    For RecNo := 2 To RecordCount Do
    Begin
      cdsRgbFamily.Append;
      cdsRgbFamily.FieldByName('CODIGO').AsString := LimpaTexto(Excel.Cells[RecNo, 1].Text);
      cdsRgbFamily.FieldByName('NOME_COR').AsString := LimpaTexto(Excel.Cells[RecNo, 2].Text);
      cdsRgbFamily.FieldByName('R').AsString := Excel.Cells[RecNo, 3].Text;
      cdsRgbFamily.FieldByName('G').AsString := Excel.Cells[RecNo, 4].Text;
      cdsRgbFamily.FieldByName('B').AsString := Excel.Cells[RecNo, 5].Text;
      cdsRgbFamily.FieldByName('FAMILIA').AsString := Excel.Cells[RecNo, 6].Text;
      cdsRgbFamily.Post;

      Gravando.RegistrarProgresso(0, RecNo, RecordCount);
    End;
  Finally
    ExcelRgb.Quit;
    ExcelRgb := Unassigned;
    Excel     := Unassigned;
  End;
end;

end.

