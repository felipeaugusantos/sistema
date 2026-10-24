unit untDacarImobiliaria;

interface

uses Uni, untTintadeMaquina, Variants;

Type
  TDacarImobiliaria = class(TTintadeMaquina)
  public
    function fGravarNovasFormulas(): Boolean; override;
  End;


  function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  function fProxCodSeq: String;
  function fDescUnid(CodUni : String): String;
  procedure pDeletaNovaFormula(strCodNfm, strCodBas, strCodFml: String);
  function fUnidadeDacar(CodUni: String): String;
  function fRetUnidadeDacar(strCodUni: String): String;
  function fFatorBase(strUniDac: String): Double;

implementation

uses untFuncoesSimples, SysUtils, DB, Math, untDacar;

function fGeraNovasFormulas(qryCadNfm: TUniQuery): Boolean;
  Var
    qryCadDac : TUniQuery;
    qryCadBas : TUniQuery;
    intCont1  : Integer;
    intCont2  : Integer;
    fltQtdCol: Double;
begin

  Try
    qryCadDac := fCriaQuery;
    qryCadDac.SQL.Text := 'DELETE FROM DAC_CADDAC WHERE DAC_PROCOD = :CODFML';
    qryCadDac.ParamByName('CODFML').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
    qryCadDac.ExecSQL;

    qryCadDac.SQL.Text := 'SELECT * FROM DAC_CADDAC LIMIT 0';
    qryCadDac.Open;

    qryCadBas := fCriaQuery;
    qryCadBas.SQL.Text := 'SELECT * FROM DAC_CADBAS WHERE BAS_CODFML = :CODFML AND BAS_BASE__ = :CODBAS';
    qryCadBas.ParamByName('CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
    qryCadBas.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
  //  qryCadBas.ParamByName('CODUNI').AsString := fRetUnidadeDacar(qryCadNfm.FieldByName('NFM_UNIDAD').AsString);
    qryCadBas.Open;

    qryCadBas.First;
    For intCont1 := 1 To qryCadBas.RecordCount Do
    Begin

      qryCadDac.Insert;
      qryCadDac.FieldByName('DAC_CODSEQ').AsString := fProxCodSeq;
      qryCadDac.FieldByName('DAC_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_BASE__').AsString + ' ' + qryCadBas.FieldByName('BAS_UNIDAD').AsString; //fUnidadeDacar(qryCadBas.FieldByName('BAS_UNIDAD').AsString);
      qryCadDac.FieldByName('DAC_REFERE').AsString := qryCadBas.fieldByName('BAS_DESCRI').AsString + ' ' + qryCadNfm.FieldByName('NFM_BASE__').AsString;

      qryCadDac.FieldByName('DAC_CODUNI').AsString := qryCadBas.FieldByName('BAS_UNIDAD').AsString; //fUnidadeDacar(qryCadBas.FieldByName('BAS_UNIDAD').AsString);
      qryCadDac.FieldByName('DAC_DESUNI').AsString := fDescUnid(qryCadDac.FieldByName('DAC_CODUNI').AsString);

      If fEmptyStr(qryCadBas.FieldByName('BAS_CODITE').AsString) Then
        qryCadDac.FieldByName('DAC_CODITE').Value := Null
      Else
        qryCadDac.FieldByName('DAC_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;

      qryCadDac.FieldByName('DAC_PROCOD').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
      qryCadDac.FieldByName('DAC_CODBAS').AsString := qryCadNfm.FieldByName('NFM_BASE__').AsString;
      qryCadDac.FieldByName('DAC_CODEMP').AsString := VS_strCodEmp;
      qryCadDac.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DAC_CADDAC', VS_strCodEmp);
      qryCadDac.FieldByName('DAC_CODFML').AsString := qryCadNfm.FieldByName('NFM_CODPRO').AsString;
  //    qryCadDac.Post;

      For intCont2 := 1 To 15 Do
      Begin
        If fEmptyStr(qryCadNfm.FieldByName('NFM_QTDC' + Format('%.2d', [intCont2])).AsString) Then
          Break;

  //      qryCadDac.Edit;
        qryCadDac.FieldByName('DAC_FORM' + Format('%.2d', [intCont2])).AsString := qryCadNfm.FieldByName('NFM_FORM' + Format('%.2d', [intCont2])).AsString;
        If qryCadNfm.FieldByName('NFM_TIPMED').AsString = 'M' Then
          qryCadDac.FieldByName('DAC_QTDB' + Format('%.2d', [intCont2])).AsFloat := qryCadNfm.FieldByName('NFM_QTDC' + Format('%.2d', [intCont2])).AsFloat
        Else
          qryCadDac.FieldByName('DAC_QTDB' + Format('%.2d', [intCont2])).AsFloat := fOncasParaMl(qryCadNfm.FieldByName('NFM_QTDC' + Format('%.2d', [intCont2])).AsString);

        fltQtdCol := qryCadDac.FieldByName('DAC_QTDB' + Format('%.2d', [intCont2])).AsFloat;
        fltQtdCol := fltQtdCol * fFatorBase(qryCadBas.FieldByName('BAS_UNIDAD').AsString);

        qryCadDac.FieldByName('DAC_QTDB' + Format('%.2d', [intCont2])).AsFloat := fltQtdCol;
  //      qryCadDac.Post;
      End;

      qryCadDac.Post;

      qryCadBas.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryCadDac);
    FreeAndNil(qryCadBas);
  End;
end;

function fFatorBase(strUniDac: String): Double;
begin
  Result := 0;

//  strUniDac := fUnidadeDacar(strUniDac);

  if (Pos(strUniDac, 'QT_LT_') > 0) then Result := 1;
  if strUniDac = 'GL' then Result := 4;
  if strUniDac = 'LA' then Result := 20;
end;

function fProxCodSeq: String;
  Var
    qryCadDac : TUniQuery;
begin
  qryCadDac := fCriaQuery;
  qryCadDac.SQL.Text := 'SELECT DAC_CODSEQ FROM DAC_CADDAC ORDER BY DAC_CODSEQ DESC LIMIT 1';
  qryCadDac.Open;
  If qryCadDac.IsEmpty Then
    Result := Format('%.6d', [1])
  Else
    Result := Format('%.6d', [qryCadDac.fieldByName('DAC_CODSEQ').AsInteger + 1]);
  FreeAndNil(qryCadDac);
end;

function fDescUnid(CodUni : String): String;
  Var
    qryCadUni : TUniQuery;
begin
  qryCadUni := fCriaQuery;
  qryCadUni.SQL.Text := 'SELECT UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI';
  qryCadUni.ParamByName('CODUNI').AsString := CodUni;
  qryCadUni.Open;
  If qryCadUni.IsEmpty Then
    Result := 'NÃO CADASTRADA'
  Else
    Result := qryCadUni.FieldByName('UNI_DESUNI').AsString;
  FreeAndNil(qryCadUni);
end;

procedure pDeletaNovaFormula(strCodNfm, strCodBas, strCodFml: String);
  Var
    qryCadNfm : TUniQuery;
    qryCadDac : TUniQuery;
begin
  qryCadNfm := fCriaQuery;
  qryCadNfm.SQL.Text := 'DELETE FROM DAC_CADNFM '+
                        ' WHERE NFM_CODNFM = :CODNFM '+
                        '   AND NFM_BASE__ = :CODBAS '+
                        '   AND NFM_CODPRO = :CODPRO';
  qryCadNfm.ParamByName('CODNFM').AsString := strCodNfm;
  qryCadNfm.ParamByName('CODBAS').AsString := strCodBas;
  qryCadNfm.ParamByName('CODPRO').AsString := strCodFml;
  qryCadNfm.ExecSQL;
  FreeAndNil(qryCadNfm);

  qryCadDac := fCriaQuery;
  qryCadDac.SQL.Text := 'DELETE FROM DAC_CADDAC '+
                        ' WHERE DAC_PROCOD = :PROCOD';
  qryCadDac.ParamByName('PROCOD').AsString := strCodNfm;
  qryCadDac.ExecSQL;
  FreeAndNil(qryCadDac);
end;

function fUnidadeDacar(CodUni: String): String;
  Var
    qryCadUni : TUniQuery;
begin
  qryCadUni := fCriaQuery;
  qryCadUni.SQL.Text := 'SELECT DAC_UNIAUT FROM DAC_UNIDAC WHERE DAC_UNIDAC = :CODUNI';
  qryCadUni.ParamByName('CODUNI').AsString := CodUni;
  qryCadUni.Open;
  If qryCadUni.IsEmpty Then
    Result := 'NÃO CADASTRADA'
  Else
    Result := qryCadUni.FieldByName('DAC_UNIAUT').AsString;
  FreeAndNil(qryCadUni);
end;

function fRetUnidadeDacar(strCodUni: String): String;
  Var
    qryCadUni : TUniQuery;
begin
  qryCadUni := fCriaQuery;
  qryCadUni.SQL.Text := 'SELECT DAC_UNIDAC FROM DAC_UNIDAC WHERE DAC_UNIAUT = :CODUNI';
  qryCadUni.ParamByName('CODUNI').AsString := strCodUni;
  qryCadUni.Open;
  If qryCadUni.IsEmpty Then
    Result := 'NÃO CADASTRADA'
  Else
    Result := qryCadUni.FieldByName('DAC_UNIDAC').AsString;
  FreeAndNil(qryCadUni);
End;


{ TDacarImobiliaria }

function TDacarImobiliaria.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM DAC_CADNFM';
  qryGen.Open;
  qryGen.First;

  pRegistraAcao('Cadastrando novas formulas....');
  While Not qryGen.Eof Do
  Begin
    fGeraNovasFormulas(qryGen);

    qryGen.Next;
    pRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;




end.
