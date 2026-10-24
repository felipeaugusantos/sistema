unit untFormulasTinta;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
  UniClientDataSet,
{$ENDIF}
  StrUtils, SysUtils, untFuncoesGenerica, Uni, Data.DB;

type
  {$M+}
  TFormulasTinta = class
    private
      FNumDoc: string;
      FEspDoc: string;
      FCodEmp: string;
      FCodCli: string;
      FCodIte: string;
      FCodAca: string;
      FEmpAca: string;
      FAutTin: string;
      FTipTin: string;
      FCodMD5: string;

      function fAlteraMD5: Boolean;
      function fBuscaDescricaoItem: string;
      function fCorrigeFormulaSuvinil: Boolean;
      function fCorrigeFormulaCoralImobiliaria: Boolean;
    public
      function fCorrigeFormula: Boolean;
    published
      property NumDoc: string read FNumDoc write FNumDoc;
      property EspDoc: string read FEspDoc write FEspDoc;
      property CodEmp: string read FCodEmp write FCodEmp;
      property CodCli: string read FCodCli write FCodCli;
      property CodIte: string read FCodIte write FCodIte;
      property CodAca: string read FCodAca write FCodAca;
      property EmpAca: string read FEmpAca write FEmpAca;
      property TipTin: string read FTipTin write FTipTin;
  end;
  {$M-}

implementation

{ TFormulasTinta }

function TFormulasTinta.fAlteraMD5: Boolean;
var
  qryMD5: TUniQuery;
  LTabela,
  LTabelaTinta,
  LPrefixo : string;
begin
  try
    try
      qryMD5 := fCriaQuery();

      If Pos(FEspDoc, 'PD_OR_') > 0 Then
      Begin
        LTabela      := 'FATDOR';
        LTabelaTinta := 'TINDOR ';
        LPrefixo     := 'FDO';
      End
      Else
      Begin
        LTabela      := 'MOVDET';
        LTabelaTinta := 'TINDET ';
        LPrefixo     := 'DET';
      End;

      qryMD5.Close;
      qryMD5.SQL.Clear;
      qryMD5.SQL.Add('UPDATE ' + LTabela);
      qryMD5.SQL.Add('SET ' + LPrefixo + '_ITETIN = :ITETIN');
      qryMD5.SQL.Add('WHERE ' + LPrefixo + '_NUMDOC = :NUMDOC');
      qryMD5.SQL.Add('AND ' + LPrefixo + '_ESPDOC = :ESPDOC');
      qryMD5.SQL.Add('AND ' + LPrefixo + '_CODEMP = :CODEMP');
      qryMD5.SQL.Add('AND ' + LPrefixo + '_CODCLI = :CODCLI');
      qryMD5.SQL.Add('AND ' + LPrefixo + '_CODITE = :CODITE');
      qryMD5.SQL.Add('AND ' + LPrefixo + '_CODACA = :CODACA');
      qryMD5.SQL.Add('AND ' + LPrefixo + '_EMPACA = :EMPACA');

      qryMD5.ParamByName('ITETIN').AsString := FCodMD5;
      qryMD5.ParamByName('NUMDOC').AsString := FNumDoc;
      qryMD5.ParamByName('ESPDOC').AsString := FEspDoc;
      qryMD5.ParamByName('CODEMP').AsString := FCodEmp;
      qryMD5.ParamByName('CODCLI').AsString := FCodCli;
      qryMD5.ParamByName('CODITE').AsString := FCodIte;
      qryMD5.ParamByName('CODACA').AsString := FCodAca;
      qryMD5.ParamByName('EMPACA').AsString := FEmpAca;

      qryMD5.ExecSQL;

      qryMD5.Close;
      qryMD5.SQL.Clear;
      qryMD5.SQL.Add('UPDATE ' + LTabelaTinta);
      qryMD5.SQL.Add('SET ' + LPrefixo + '_ITETIN = :ITETIN');
      qryMD5.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      qryMD5.ParamByName('ITETIN').AsString := FCodMD5;
      qryMD5.ParamByName('AUTINC').AsString := FAutTin;

      qryMD5.ExecSQL;

      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryMD5);
  end;
end;

function TFormulasTinta.fBuscaDescricaoItem: string;
var
  qryDescri: TUniQuery;
begin
  Result := '';
  try
    qryDescri := fCriaQuery();
    qryDescri.SQL.Add('SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE');
    qryDescri.ParamByName('CODITE').AsString := FCodIte;
{$IFDEF LINUX}
    Result := ExecutarQueryEmCache(qryDescri).FieldByName('ITE_DESITE').AsString;
{$ELSE}
    qryDescri.Open;
    Result := qryDescri.FieldByName('ITE_DESITE').AsString;
{$ENDIF}
  finally
    FreeAndNil(qryDescri);
  end;
end;

function TFormulasTinta.fCorrigeFormula: Boolean;
begin
  Result := False;
  fStartTransaction;
  case AnsiIndexStr(UpperCase(FTipTin), ['SUV','CIM']) of
    0: Result := fCorrigeFormulaSuvinil;
    1: Result := fCorrigeFormulaCoralImobiliaria;
  end;

  if Result then
  begin
    Result := fAlteraMD5;
  end;

  if Result then
  begin
    fCommit;
  end
  else
  begin
    fRollBack;
  end;
end;

function TFormulasTinta.fCorrigeFormulaCoralImobiliaria: Boolean;

  function fRetProximoCodSeqCoral: string;
  var
    qryCodSeq: TUniQuery;
  begin
    try
      qryCodSeq := fCriaQuery();
      qryCodSeq.SQL.Add('SELECT IFNULL(MAX(COR_CODSEQ), 0) + 1 AS MAXIMO FROM CORIMO_CADCOR');
      qryCodSeq.Open;

      Result := fStrZero(IntToStr(qryCodSeq.FieldByName('MAXIMO').AsInteger),6);
    finally
      FreeAndNil(qryCodSeq);
    end;
  end;

var
  qryCoral: TUniQuery;
  qryCadCor: TUniQuery;
  strDesCoral: string;
  strDesCoralCompleto: string;
  strUnidade: string;
  strMD5: string;
  intCont: integer;
  fltQtdConv: Double;
  LTabelaTinta,
  LPrefixo : string;
begin
  try
    try
      If Pos(FEspDoc, 'PD_OR_') > 0 Then
      Begin
        LTabelaTinta := 'TINDOR ';
        LPrefixo     := 'FDO';
      End
      Else
      Begin
        LTabelaTinta := 'TINDET ';
        LPrefixo     := 'DET';
      End;


      qryCoral := fCriaQuery();
      qryCoral.SQL.Add('SELECT * FROM ' + LTabelaTinta);
      qryCoral.SQL.Add('WHERE ' + LPrefixo + '_NUMDOC = :NUMDOC ');
      qryCoral.SQL.Add('AND ' + LPrefixo + '_ESPDOC = :ESPDOC');
      qryCoral.SQL.Add('AND ' + LPrefixo + '_CODEMP = :CODEMP');
      qryCoral.SQL.Add('AND ' + LPrefixo + '_CODCLI = :CODCLI');
      qryCoral.SQL.Add('AND ' + LPrefixo + '_CODITE = :CODITE');
      qryCoral.SQL.Add('AND ' + LPrefixo + '_CODACA = :CODACA ');
      qryCoral.SQL.Add('AND ' + LPrefixo + '_EMPACA = :EMPACA');

      qryCoral.ParamByName('NUMDOC').AsString := FNumDoc;
      qryCoral.ParamByName('ESPDOC').AsString := FEspDoc;
      qryCoral.ParamByName('CODEMP').AsString := FCodEmp;
      qryCoral.ParamByName('CODCLI').AsString := FCodCli;
      qryCoral.ParamByName('CODITE').AsString := FCodIte;
      qryCoral.ParamByName('CODACA').AsString := FCodAca;
      qryCoral.ParamByName('EMPACA').AsString := FEmpAca;

      qryCoral.Open;

      if qryCoral.IsEmpty then
      begin
        Result := False;
        Exit;
      end;

      FAutTin := qryCoral.FieldByName('AUTOINCREM').AsString;
      strDesCoralCompleto := qryCoral.FieldByName(LPrefixo + '_DESCRI').AsString;
      strDesCoral := fBuscaDescricaoItem;

      //Pega as informações que formarão os campos COR_DESCRI, COR_UNIVER, COR_UNIDAD, COR_CODUNI E COR_DESPRO da tabela CORIMO_CADCOR,
      //Estas informações estão concatenadas no campo DET_DESCRI da tabela TINDET.
      Delete(strDesCoralCompleto,Pos(strDesCoral,strDesCoralCompleto),Length(strDesCoral));
      strDesCoralCompleto := Trim(strDesCoralCompleto);
      strUnidade := Copy(strDesCoralCompleto,Length(strDesCoralCompleto)-1,2);
      strDesCoralCompleto := Trim(strDesCoralCompleto);
      Delete(strDesCoralCompleto,Pos(strUnidade,strDesCoralCompleto),Length(strUnidade));
      strDesCoralCompleto := Trim(strDesCoralCompleto);

      //Cria MD5
      strMD5 := strDesCoralCompleto + strUnidade + strDesCoral + strUnidade + strDesCoralCompleto;
      FCodMD5 := GetMD5(strMD5);

      qryCadCor := fCriaQuery();
      qryCadCor.SQL.Add('SELECT * FROM CORIMO_CADCOR WHERE FALSE');
      qryCadCor.Open;
      qryCadCor.Insert;

      qryCadCor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADCOR', FCodEmp);
      qryCadCor.FieldByName('COR_CODEMP').AsString := FCodEmp;
      qryCadCor.FieldByName('COR_CODSEQ').AsString := fRetProximoCodSeqCoral;
      qryCadCor.FieldByName('COR_MD5KEY').AsString := FCodMD5;
      qryCadCor.FieldByName('COR_DESCRI').AsString := strDesCoralCompleto;
      qryCadCor.FieldByName('COR_UNIDAD').AsString := strUnidade;
      qryCadCor.FieldByName('COR_DESPRO').AsString := strDesCoral;
      qryCadCor.FieldByName('COR_UNIVER').AsString := strDesCoralCompleto;
      qryCadCor.FieldByName('COR_CODUNI').AsString := strUnidade;

      for intCont := 1 to 20 do
      begin
        if (qryCoral.FieldByName(LPrefixo + '_QTDITE').AsFloat = 0) or (qryCoral.FieldByName(LPrefixo + '_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat = 0) then
        begin
          fltQtdConv := 0;
        end
        else
        begin
          //Cálculo de conversão de pulso para ML (coral utiliza fator 0,308 para pulso)
          fltQtdConv := (qryCoral.FieldByName(LPrefixo + '_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat / 0.308) / qryCoral.FieldByName(LPrefixo + '_QTDITE').AsFloat;
        end;

        qryCadCor.FieldByName('COR_FORM' + fStrZero(IntToStr(intCont), 2)).AsString := qryCoral.FieldByName(LPrefixo + '_FORM' + fStrZero(IntToStr(intCont), 2)).AsString;
        qryCadCor.FieldByName('COR_QTDC' + fStrZero(IntToStr(intCont), 2)).AsFloat  := fltQtdConv;
      end;

      qryCadCor.Post;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCoral);
    FreeAndNil(qryCadCor);
  end;
end;

function TFormulasTinta.fCorrigeFormulaSuvinil: Boolean;
var
  qrySuvinil: TUniQuery;
  qryCadSuv: TUniQuery;
  strMD5: string;
  strNomCor: string;
  intCont: integer;
  fltQtdConv: Double;
  LTabelaTinta,
  LPrefixo : string;
begin
  try
    try
      If Pos(FEspDoc, 'PD_OR_') > 0 Then
      Begin
        LTabelaTinta := 'TINDOR ';
        LPrefixo     := 'FDO';
      End
      Else
      Begin
        LTabelaTinta := 'TINDET ';
        LPrefixo     := 'DET';
      End;

      qrySuvinil := fCriaQuery();
      qrySuvinil.SQL.Add('SELECT * FROM ' + LTabelaTinta);
      qrySuvinil.SQL.Add('WHERE ' + LPrefixo + '_NUMDOC = :NUMDOC ');
      qrySuvinil.SQL.Add('AND ' + LPrefixo + '_ESPDOC = :ESPDOC');
      qrySuvinil.SQL.Add('AND ' + LPrefixo + '_CODEMP = :CODEMP');
      qrySuvinil.SQL.Add('AND ' + LPrefixo + '_CODCLI = :CODCLI');
      qrySuvinil.SQL.Add('AND ' + LPrefixo + '_CODITE = :CODITE');
      qrySuvinil.SQL.Add('AND ' + LPrefixo + '_CODACA = :CODACA ');
      qrySuvinil.SQL.Add('AND ' + LPrefixo + '_EMPACA = :EMPACA');

      qrySuvinil.ParamByName('NUMDOC').AsString := FNumDoc;
      qrySuvinil.ParamByName('ESPDOC').AsString := FEspDoc;
      qrySuvinil.ParamByName('CODEMP').AsString := FCodEmp;
      qrySuvinil.ParamByName('CODCLI').AsString := FCodCli;
      qrySuvinil.ParamByName('CODITE').AsString := FCodIte;
      qrySuvinil.ParamByName('CODACA').AsString := FCodAca;
      qrySuvinil.ParamByName('EMPACA').AsString := FEmpAca;

      qrySuvinil.Open;

      if qrySuvinil.IsEmpty then
      begin
        Result := False;
        Exit;
      end;

      FAutTin := qrySuvinil.FieldByName('AUTOINCREM').AsString;

      //Pega o nome cor
      strNomCor := Trim(qrySuvinil.FieldByName(LPrefixo + '_DESCRI').AsString);
      Delete(strNomCor,Pos(qrySuvinil.FieldByName(LPrefixo + '_REFERE').AsString,strNomCor),Length(qrySuvinil.FieldByName(LPrefixo + '_REFERE').AsString));
      strNomCor := Trim(strNomCor);
      strNomCor := Trim(Copy(strNomCor,1,Length(strNomCor)-3));

      strMD5 := qrySuvinil.FieldByName(LPrefixo + '_UNIDAD').AsString + strNomCor + strNomCor + qrySuvinil.FieldByName(LPrefixo + '_REFERE').AsString + qrySuvinil.FieldByName(LPrefixo + '_UNIDAD').AsString;

      qryCadSuv := fCriaQuery();
      qryCadSuv.SQL.Add('SELECT * FROM SUV_CADSUV WHERE FALSE');
      qryCadSuv.Open;
      qryCadSuv.Insert;

      qryCadSuv.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SUV_CADSUV', FCodEmp);
      qryCadSuv.FieldByName('SUV_CODEMP').AsString := FCodEmp;
      qryCadSuv.FieldByName('SUV_DESCRI').AsString := strNomCor;
      qryCadSuv.FieldByName('SUV_REFERE').AsString := qrySuvinil.FieldByName(LPrefixo + '_REFERE').AsString;
      qryCadSuv.FieldByName('SUV_UNIDAD').AsString := qrySuvinil.FieldByName(LPrefixo + '_UNIDAD').AsString;

      for intCont := 1 to 20 do
      begin
        if (qrySuvinil.FieldByName(LPrefixo + '_QTDITE').AsFloat = 0) or (qrySuvinil.FieldByName(LPrefixo + '_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat = 0) then
        begin
          fltQtdConv := 0;
        end
        else
        begin
          //Cálculo de conversão de pulso para ML (Suvinil utiliza fator 0,154 para pulso)
          fltQtdConv := (qrySuvinil.FieldByName(LPrefixo + '_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat / 0.154) / qrySuvinil.FieldByName(LPrefixo + '_QTDITE').AsFloat;
        end;

        strMD5 := strMD5 + qrySuvinil.FieldByName(LPrefixo + '_FORM' + fStrZero(IntToStr(intCont), 2)).AsString;
        strMD5 := strMD5 + StringReplace(FormatFloat('0.0000', fltQtdConv),',', '.', [rfReplaceAll]);

        qryCadSuv.FieldByName('SUV_FORM' + fStrZero(IntToStr(intCont), 2)).AsString := qrySuvinil.FieldByName(LPrefixo + '_FORM' + fStrZero(IntToStr(intCont), 2)).AsString;
        qryCadSuv.FieldByName('SUV_QTDB' + fStrZero(IntToStr(intCont), 2)).AsFloat  := fltQtdConv;
      end;

      //Cria MD5
      FCodMD5 := GetMD5(strMD5);

      qryCadSuv.FieldByName('SUV_MD5KEY').AsString := FCodMD5;

      qryCadSuv.Post;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qrySuvinil);
    FreeAndNil(qryCadSuv);
  end;
end;

end.
