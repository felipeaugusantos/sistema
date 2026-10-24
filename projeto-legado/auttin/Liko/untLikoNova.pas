unit untLikoNova;

interface

uses untTintadeMaquina, Classes, Uni, Variants,  Dialogs,
  ADODB,  DB, ComObj ;

Type
  TLikoDinamica = class(TTintadeMaquina)
  private
    strPath: String;
    qryCadBas: TUniQuery;
    qryCadEmb: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadUni: TUniQuery;

    blnTruncou: Boolean;

    function fProcessarCadLik: Boolean;
    function fProcessarCadBas: Boolean;
    function fProcessarCadCol: Boolean;
    function fProcessarCadEmb: Boolean;

    function fStrToFloatLiko(strValorUnico: String): Double;    

  public
    function fProcessarArquivos(intOpcao: Integer): Boolean;
    function fGravarNovasFormulas: Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  End;

  procedure pDeletaNovaFormula(strCodigo: String);
  function fGravaNovasFormulasDin(qryCadNfm: TUniQuery): Boolean;
  function fRetProximoCodSeq: Integer;
  function fRetCodEmbalagem(strCodEmbOrigem: String; strUniDes: String): String;

implementation

uses untFuncoesSimples, SysUtils, untFuncoes, StrUtils, untFuncTinta,
  untModuloTinta;



{ TLikoDinamica }

constructor TLikoDinamica.Create(AOwner: TComponent);
begin
  inherited;
  strPath := fGetConfTinta('LIK').fGet('TXTCOR');
  blnTruncou := False;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Add(' SELECT DISTINCT ');
  qryCadBas.SQL.Add('   AUTOINCREM, ');
  qryCadBas.SQL.Add('   BAS_BASE__, ');
  qryCadBas.SQL.Add('   BAS_DESCRI, ');
  qryCadBas.SQL.Add('   BAS_UNIDAD ');
  qryCadBas.SQL.Add(' FROM LIK_CADBAS ');
  qryCadBas.Open;

  qryCadEmb := fCriaQuery(Self);
  qryCadEmb.SQL.Add(' SELECT ');
  qryCadEmb.SQL.Add('   AUTOINCREM, ');
  qryCadEmb.SQL.Add('   EMB_CODEMB, ');
  qryCadEmb.SQL.Add('   EMB_UNIDAD ');
  qryCadEmb.SQL.Add(' FROM LIK_CADEMB ');
  qryCadEmb.Open;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Add(' SELECT ');
  qryCadCol.SQL.Add('   AUTOINCREM, ');
  qryCadCol.SQL.Add('   COL_CODCOL ');
  qryCadCol.SQL.Add(' FROM LIK_CADCOL ');
  qryCadCol.Open;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Add(' SELECT ');
  qryCadUni.SQL.Add('   EMB_CODEMB, ');
  qryCadUni.SQL.Add('   UNI_SIGUNI ');
  qryCadUni.SQL.Add(' FROM LIK_CADEMB ');
  qryCadUni.SQL.Add('   INNER JOIN CADUNI ');
  qryCadUni.SQL.Add('     ON EMB_UNIDAD = UNI_CODUNI ');
  qryCadUni.Open;
end;

destructor TLikoDinamica.Destroy;
begin
  qryCadBas.Free;
  qryCadEmb.Free;
  qryCadCol.Free;
  qryCadUni.Free;
  inherited;
end;

function fGravaNovasFormulasDin(qryCadNfm: TUniQuery): Boolean;
   Var
    qryGen: TUniQuery;
    intCont: Integer;
    intUnidade: Integer;
    blnGerUnids: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (0.25, 1, 5);
begin
  qryGen := fCriaQuery(qryCadNfm);

  qryGen.SQL.Text := 'DELETE FROM LIK_CADLIK WHERE LIK_CODIGO = ' +
    QuotedStr(qryCadNfm.FieldByName('NFM_CODIGO').AsString);
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO LIK_CADLIK ');
  qryGen.SQL.Add('             (LIK_CODSEQ, ');
  qryGen.SQL.Add('              LIK_CODEMP, ');
  qryGen.SQL.Add('              LIK_DESCRI, ');
  qryGen.SQL.Add('              LIK_CODIGO, ');
  qryGen.SQL.Add('              LIK_UNIDAD, ');
  qryGen.SQL.Add('              LIK_CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              LIK_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              LIK_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('              AUTOINCREM, ');
  qryGen.SQL.Add('              LIK_CODEMB, ');
  qryGen.SQL.Add('              LIK_CODUNI, ');
  qryGen.SQL.Add('              LIK_DTACAD, ');
  qryGen.SQL.Add('              LIK_MD5KEY) ');
  qryGen.SQL.Add(' VALUES (:CODSEQ, ');
  qryGen.SQL.Add('         :CODEMP, ');
  qryGen.SQL.Add('         :DESCRI, ');
  qryGen.SQL.Add('         :CODIGO, ');
  qryGen.SQL.Add('         :UNIDAD, ');
  qryGen.SQL.Add('         :CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('         :FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('         :QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('         :AUTOINCREM, ');
  qryGen.SQL.Add('         :CODEMB, ');
  qryGen.SQL.Add('         :CODUNI, ');
  qryGen.SQL.Add('         :DTACAD, ');
  qryGen.SQL.Add('         :MD5KEY); ');

  blnGerUnids := qryCadNfm.FieldByName('NFM_GERUNI').AsInteger = 2;

  For intUnidade := 1 To 3 Do
  Begin
    qryGen.ParamByName('CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryGen.ParamByName('CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;

    qryGen.ParamByName('UNIDAD').AsString :=
      IfThen(blnGerUnids, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnidade]);

    qryGen.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LIK_CADLIK', VS_strCodEmp);

    If blnGerUnids Then
    Begin
      qryGen.ParamByName('CODEMB').AsString := qryCadNfm.FieldByName('NFM_CODEMB').AsString;
    End
    Else
    Begin
      qryGen.ParamByName('CODEMB').AsString :=
        fRetCodEmbalagem(qryCadNfm.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnidade]);
    End;

    qryGen.ParamByName('CODUNI').AsString := qryGen.ParamByName('UNIDAD').AsString;

    For intCont := 1 To 10 Do
    Begin
      qryGen.ParamByName('FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
      qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=
        qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * Iif(blnGerUnids, 1, arrFator[intUnidade]);
    End;

    qryGen.ParamByName('DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;
    qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('DESCRI').AsString +
                                              qryGen.ParamByName('CODIGO').AsString +
                                              qryGen.ParamByName('UNIDAD').AsString +
                                              qryGen.ParamByName('CODBAS').AsString +
                                              qryGen.ParamByName('CODEMB').AsString +
                                              qryGen.ParamByName('CODUNI').AsString );
    qryGen.ExecSQL;

    If blnGerUnids Then Break;
  End;

  Result := True;
end;

function TLikoDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadLik: TUniQuery;
    intCont: Integer;
    intUnid: Integer;
    blnUnid: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (0.25, 1, 5);
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM LIK_CADLIK WHERE LIK_CODIGO IN (SELECT NFM_CODIGO FROM LIK_CADNFM);';
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM LIK_CADNFM ');
  qryGen.SQL.Add('   INNER JOIN LIK_CADBAS ');
  qryGen.SQL.Add('     ON NFM_CODBAS = BAS_BASE__ ');
  qryGen.SQL.Add('       AND NFM_DESPRO = BAS_DESCRI ');
  qryGen.SQL.Add('       AND NFM_UNIDAD = BAS_UNIDAD; ');
  qryGen.Open;
  qryGen.First;

  qryCadLik := fCriaQuery(Self);
  qryCadLik.SQL.Text := 'SELECT * FROM LIK_CADLIK WHERE FALSE';
  qryCadLik.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('LIK_CADLIK', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    blnUnid := qryGen.FieldByName('NFM_GERUNI').AsInteger <> 1;


    For intUnid := 1 To 3 Do
    Begin
      qryCadLik.Insert;

      qryCadLik.FieldByName('LIK_CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
      qryCadLik.FieldByName('LIK_CODEMP').AsString := VS_strCodEmp;
      qryCadLik.FieldByName('LIK_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString;
      qryCadLik.FieldByName('LIK_CODIGO').AsString := qryGen.FieldByName('NFM_CODIGO').AsString;
      qryCadLik.FieldByName('LIK_UNIDAD').AsString := IfThen(blnUnid, qryGen.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnid]);
      qryCadLik.FieldByName('LIK_CODBAS').AsString := qryGen.FieldByName('NFM_CODBAS').AsString;

      For intCont := 1 To 10 Do
      Begin

        If fEmptyStr(qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        qryCadLik.FieldByName('LIK_FORM' + fStrZero(intCont, 2)).AsString :=
          qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;

        qryCadLik.FieldByName('LIK_QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryGen.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * IIF(blnUnid, 1, arrFator[intUnid]);
      End;

      qryCadLik.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LIK_CADLIK', VS_strCodEmp);

      If blnUnid Then
      Begin
        qryCadLik.FieldByName('LIK_CODEMB').AsString := qryGen.FieldByName('NFM_CODEMB').AsString;
      End
      Else
      Begin
        qryCadLik.FieldByName('LIK_CODEMB').AsString :=
          fRetCodEmbalagem(qryGen.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnid]);
      End;

      qryCadLik.FieldByName('LIK_CODUNI').AsString := qryCadLik.FieldByName('LIK_UNIDAD').AsString;
      qryCadLik.FieldByName('LIK_MD5KEY').AsString := GetMD5(qryCadLik.FieldByName('LIK_DESCRI').AsString +
                                                        qryCadLik.FieldByName('LIK_CODIGO').AsString +
                                                        qryCadLik.FieldByName('LIK_UNIDAD').AsString +
                                                        qryCadLik.FieldByName('LIK_CODBAS').AsString +
                                                        qryCadLik.FieldByName('LIK_CODEMB').AsString +
                                                        qryCadLik.FieldByName('LIK_CODUNI').AsString );

      qryCadLik.Post;

      If blnUnid Then Break;
    End;
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TLikoDinamica.fProcessarArquivos(intOpcao: Integer): Boolean;
begin
  Try
    Result := True;
    Case intOpcao of
      0: Result := fProcessarCadCol and fProcessarCadEmb;
      1: Result := fProcessarCadBas;
      2: Result := fProcessarCadLik;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TLikoDinamica.fProcessarArquivos');
    End;
  end;
end;

function TLikoDinamica.fProcessarCadBas: Boolean;
var
  olePlanilha, oleSheet: OleVariant;
  intLinha, intUltLinha: Integer;
  blnFimPlan: Boolean;
  qryCadbas: TUniQuery;
  intUnid: Integer;
Const
  arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
begin
  Try
    qryCadBas := fCriaQuery;
    olePlanilha := CreateOleObject('Excel.Application');
    Try
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(strPath);
      oleSheet := olePlanilha.WorkSheets[1];

      intUltLinha := 2;
      blnFimPlan := False;
      While not blnFimPlan Do
      Begin
        Inc(intUltLinha);
        If oleSheet.Cells[intUltLinha, 1].Text = '' Then
        Begin
          blnFimPlan := True;
          Dec(intUltLinha);
        end;
      end;

      qryCadBas.SQL.Text := 'SELECT * FROM LIK_CADBAS';
      qryCadBas.Open;

      pRegistraAcao('Processando cadastro de bases...');

      For intLinha := 2 to intUltLinha Do
      Begin
        for intUnid := 1 to 3 do
        begin
          If Not qryCadBas.Locate('BAS_BASE__;BAS_UNIDAD;BAS_CODEMP', VarArrayOf([oleSheet.Cells[intLinha, 5].Text, arrUnid[intUnid], VS_strCodEmp]), []) Then
          Begin
            qryCadbas.Insert;
            qryCadbas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LIK_CADBAS', VS_strCodEmp);
            qryCadbas.FieldByName('BAS_BASE__').AsString := oleSheet.Cells[intLinha, 5].Text;
            qryCadbas.FieldByName('BAS_DESCRI').AsString := oleSheet.Cells[intLinha, 5].Text;
            qryCadbas.FieldByName('BAS_UNIDAD').AsString := arrUnid[intUnid];
            qryCadbas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
            qryCadbas.FieldByName('BAS_PRECUS').AsFloat  := 0.00;
            qryCadbas.FieldByName('BAS_PREVEN').AsFloat  := 0.00;
            qryCadbas.FieldByName('BAS_MARGEM').AsFloat  := 0.00;
            qryCadbas.FieldByName('BAS_CODITE').Value    := Null;
            qryCadbas.Post;
          End;
        end;
        pRegistraProgresso(0, intLinha - 1, intUltLinha - 1);
      end;
      pRegistraAcao('Cadastro de bases processado com sucesso!');
      Result := True;
    Finally
      If Assigned(qryCadbas) Then
        FreeAndNil(qryCadbas);

      If Not VarIsEmpty(olePlanilha) Then
      Begin
        olePlanilha.Quit;
        olePlanilha := Unassigned;
        oleSheet := Unassigned;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLikoNova.fProcessarCadBas]');
      Result := False;
    End;
  End;
end;

function TLikoDinamica.fProcessarCadCol: Boolean;
var
  olePlanilha, oleSheet: OleVariant;
  intLinha, intUltLinha: Integer;
  qryCadCol: TUniQuery;
  blnFimPlan: Boolean;
begin
  Try
    Result := False;
    olePlanilha := CreateOleObject('Excel.Application');
    qryCadCol := fCriaQuery();
    Try
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(strPath);
      oleSheet := olePlanilha.WorkSheets[3];

      intUltLinha := 6;
      blnFimPlan := False;
      While not blnFimPlan Do
      Begin
        Inc(intUltLinha);
        If oleSheet.Cells[intUltLinha, 1].Text = '' Then
        Begin
          blnFimPlan := True;
          Dec(intUltLinha);
        end;
      end;

      qryCadCol.SQL.Add(' INSERT INTO LIK_CADCOL ');
      qryCadCol.SQL.Add('             (AUTOINCREM, ');
      qryCadCol.SQL.Add('              COL_CODCOL, ');
      qryCadCol.SQL.Add('              COL_DESCRI, ');
      qryCadCol.SQL.Add('              COL_PESESP, ');
      qryCadCol.SQL.Add('              COL_CODEMP) ');
      qryCadCol.SQL.Add(' VALUES (:AUTOINCREM, ');
      qryCadCol.SQL.Add('         :COL_CODCOL, ');
      qryCadCol.SQL.Add('         :COL_DESCRI, ');
      qryCadCol.SQL.Add('         :COL_PESESP, ');
      qryCadCol.SQL.Add('         :COL_CODEMP);');

      pRegistraAcao('Processando cadastro de colorantes...');

      For intLinha := 6 to intUltLinha do
      Begin
        qryCadCol.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LIK_CADCOL', VS_strCodEmp);
        qryCadCol.ParamByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryCadCol.ParamByName('COL_CODCOL').AsString := oleSheet.Cells[intLinha, 2].Text;
        qryCadCol.ParamByName('COL_DESCRI').AsString := oleSheet.Cells[intLinha, 1].Text;
        qryCadCol.ParamByName('COL_PESESP').AsFloat  := fStrToFloat(oleSheet.Cells[intLinha, 3].Text);

        Try
          qryCadCol.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then //DUPLICADO
              pRegistraAcao(Format('Colorante %s já está cadastrado.',
              [oleSheet.Cells[intLinha, 2].Text]))
            Else
              Raise;
          End;
        End;

        pRegistraProgresso(0, intLinha - 5, intUltLinha - 5);
      end;
      pRegistraAcao('Cadastro de colorantes processado com sucesso!');

      Result := True;
    Finally
      If Assigned(qryCadCol) Then
        FreeAndNil(qryCadCol);

      If Not VarIsEmpty(olePlanilha) Then
      Begin
        olePlanilha.Quit;
        olePlanilha := Unassigned;
        oleSheet := Unassigned;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLikoNova.fProcessarCadCol]');
      Result := False;
    End;
  End;
end;

function TLikoDinamica.fProcessarCadEmb: Boolean;
var
  olePlanilha, oleSheet: OleVariant;
  intLinha, intCont, intUltLinha: Integer;
  qryCadEmb: TUniQuery;
  blnFimPlan: Boolean;
begin
  Try
    Result := False;
    olePlanilha := CreateOleObject('Excel.Application');
    qryCadEmb := fCriaQuery();
    Try
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(strPath);

      oleSheet := olePlanilha.WorkSheets[2];

      intUltLinha := 6;
      blnFimPlan := False;
      While not blnFimPlan Do
      Begin
        Inc(intUltLinha);
        If oleSheet.Cells[intUltLinha, 1].Text = '' Then
        Begin
          blnFimPlan := True;
          Dec(intUltLinha);
        end;
      end;

      qryCadEmb.SQL.Add(' INSERT INTO LIK_CADEMB ');
      qryCadEmb.SQL.Add('             (AUTOINCREM, ');
      qryCadEmb.SQL.Add('              EMB_CODEMB, ');
      qryCadEmb.SQL.Add('              EMB_CODEMP, ');
      qryCadEmb.SQL.Add('              EMB_QTDEMB, ');
      qryCadEmb.SQL.Add('              EMB_UNIDAD) ');
      qryCadEmb.SQL.Add(' VALUES (:AUTOINCREM, ');
      qryCadEmb.SQL.Add('         :EMB_CODEMB, ');
      qryCadEmb.SQL.Add('         :EMB_CODEMP, ');
      qryCadEmb.SQL.Add('         :EMB_QTDEMB, ');
      qryCadEmb.SQL.Add('         :EMB_UNIDAD); ');

      pRegistraAcao('Processando cadastro de embalagens...');

      intCont := 1;
      For intLinha := 6 to intUltLinha do
      Begin
        qryCadEmb.ParamByName('AUTOINCREM').AsString  := fRetAutoIncrem('LIK_CADEMB', VS_strCodEmp);
        qryCadEmb.ParamByName('EMB_CODEMB').AsInteger := intCont;
        qryCadEmb.ParamByName('EMB_CODEMP').AsString  := VS_strCodEmp;
        qryCadEmb.ParamByName('EMB_QTDEMB').AsFloat   := fStrToFloat(oleSheet.Cells[intLinha, 2].Text);
        If UpperCase(oleSheet.Cells[intLinha, 1].Text) = 'QUARTO' Then
          qryCadEmb.ParamByName('EMB_UNIDAD').AsString := 'LT'
        Else If UpperCase(oleSheet.Cells[intLinha, 1].Text) = 'GALÃO' Then
          qryCadEmb.ParamByName('EMB_UNIDAD').AsString := 'GL'
        Else
          qryCadEmb.ParamByName('EMB_UNIDAD').AsString := 'LA';

        Try
          qryCadEmb.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then //DUPLICADO
              pRegistraAcao(Format('Embalagem %s já está cadastrada.',
              [oleSheet.Cells[intLinha, 1].Text]))
            Else
              Raise;
          End;
        End;

        Inc(intCont);
        pRegistraProgresso(0, intLinha - 5, intUltLinha - 5);
      end;
      pRegistraAcao('Cadastro de embalagens processado com sucesso!');

      Result := True;
    Finally
      If Assigned(qryCadEmb) Then
        FreeAndNil(qryCadEmb);

      If Not VarIsEmpty(olePlanilha) Then
      Begin
        olePlanilha.Quit;
        olePlanilha := Unassigned;
        oleSheet := Unassigned;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLikoNova.fProcessarCadEmb]');
      Result := False;
    End;
  End;
end;

function TLikoDinamica.fProcessarCadLik: Boolean;
  Var
    olePlanilha, oleSheet: OleVariant;
    intLinha, intUltLinha: Integer;
    blnFimPlan: Boolean;
    qryCadLik: TUniQuery;
    intForm: Integer;
    intCodSeq,
    intUnid: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (0.25, 1, 5);

  function fRetProximoCodSeq: Integer;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(LIK_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM LIK_CADLIK;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
    FreeAndNil(qryGen);
  end;

  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM LIK_CADLIK';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryCadLik.Params.Count - 1 Do
    Begin
      qryCadLik.Params.Items[i].Value := Null;
    End;
  End;
begin
  Try
    Result := False;
    pDeletaRegistros;

    olePlanilha := CreateOleObject('Excel.Application');
    qryCadLik := fCriaQuery();
    Try
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(strPath);
      oleSheet := olePlanilha.WorkSheets[1];

      intUltLinha := 2;
      blnFimPlan := False;
      While not blnFimPlan Do
      Begin
        Inc(intUltLinha);
        If oleSheet.Cells[intUltLinha, 1].Text = '' Then
        Begin
          blnFimPlan := True;
          Dec(intUltLinha);
        end;
      end;

      qryCadLik.SQL.Add(' INSERT INTO LIK_CADLIK ');
      qryCadLik.SQL.Add('             (LIK_CODSEQ, ');
      qryCadLik.SQL.Add('              LIK_CODEMP, ');
      qryCadLik.SQL.Add('              LIK_DESCRI, ');
      qryCadLik.SQL.Add('              LIK_CODIGO, ');
      qryCadLik.SQL.Add('              LIK_UNIDAD, ');
      qryCadLik.SQL.Add('              LIK_CODBAS, ');
      qryCadLik.SQL.Add('              LIK_CODEMB, ');
      qryCadLik.SQL.Add('              LIK_CODUNI, ');
      qryCadLik.SQL.Add('              LIK_PRODUT, ');
      qryCadLik.SQL.Add('              LIK_ACABAM, ');
      qryCadLik.SQL.Add('              LIK_MD5KEY, ');

      For intForm := 1 To 6 Do
      Begin
        qryCadLik.SQL.Add('            LIK_FORM' + fStrZero(intForm, 2) + ', ');
        qryCadLik.SQL.Add('            LIK_QTDC' + fStrZero(intForm, 2) + ', ');
      End;

      qryCadLik.SQL.Add('              AUTOINCREM) ');
      qryCadLik.SQL.Add(' VALUES (:LIK_CODSEQ, ');
      qryCadLik.SQL.Add('         :LIK_CODEMP, ');
      qryCadLik.SQL.Add('         :LIK_DESCRI, ');
      qryCadLik.SQL.Add('         :LIK_CODIGO, ');
      qryCadLik.SQL.Add('         :LIK_UNIDAD, ');
      qryCadLik.SQL.Add('         :LIK_CODBAS, ');
      qryCadLik.SQL.Add('         :LIK_CODEMB, ');
      qryCadLik.SQL.Add('         :LIK_CODUNI, ');
      qryCadLik.SQL.Add('         :LIK_PRODUT, ');
      qryCadLik.SQL.Add('         :LIK_ACABAM, ');
      qryCadLik.SQL.Add('         :LIK_MD5KEY, ');

      For intForm := 1 To 6 Do
      Begin
        qryCadLik.SQL.Add('       :LIK_FORM' + fStrZero(intForm, 2) + ', ');
        qryCadLik.SQL.Add('       :LIK_QTDC' + fStrZero(intForm, 2) + ', ');
      End;

      qryCadLik.SQL.Add('         :AUTOINCREM); ');

      pRegistraAcao('Processando cadastro de Fórmulas...');

      intCodSeq := 0;

      For intLinha := 2 to intUltLinha do
      Begin
        for intUnid := 1 to 3 Do
        Begin
          Limpar;

          Inc(intCodSeq);
          qryCadLik.ParamByName('AUTOINCREM').AsString  := fRetAutoIncrem('LIK_CADLIK', VS_strCodEmp);
          qryCadLik.ParamByName('LIK_CODSEQ').AsString  := fStrZero(intCodSeq, 6);
          qryCadLik.ParamByName('LIK_CODEMP').AsString  := VS_strCodEmp;
          qryCadLik.ParamByName('LIK_DESCRI').AsString  := AnsiUpperCase(oleSheet.Cells[intLinha, 4].Text);
          qryCadLik.ParamByName('LIK_CODIGO').AsString  := oleSheet.Cells[intLinha, 3].Text;
          qryCadLik.ParamByName('LIK_UNIDAD').AsString  := arrUnid[intUnid];
          qryCadLik.ParamByName('LIK_CODUNI').AsString  := arrUnid[intUnid];
          qryCadLik.ParamByName('LIK_CODBAS').AsString  := oleSheet.Cells[intLinha, 5].Text;
          qryCadLik.ParamByName('LIK_CODEMB').AsString  := fRetCodEmbalagem('2',arrUnid[intUnid]);
          qryCadLik.ParamByName('LIK_PRODUT').AsString  := oleSheet.Cells[intLinha, 1].Text;
          qryCadLik.ParamByName('LIK_ACABAM').AsString  := oleSheet.Cells[intLinha, 2].Text;
          qryCadLik.ParamByName('LIK_MD5KEY').AsString  := GetMD5(qryCadLik.ParamByName('LIK_DESCRI').AsString +
                                                             qryCadLik.ParamByName('LIK_CODIGO').AsString +
                                                             qryCadLik.ParamByName('LIK_UNIDAD').AsString +
                                                             qryCadLik.ParamByName('LIK_CODBAS').AsString +
                                                             qryCadLik.ParamByName('LIK_CODEMB').AsString +
                                                             qryCadLik.ParamByName('LIK_CODUNI').AsString +
                                                             qryCadLik.ParamByName('LIK_PRODUT').AsString +
                                                             qryCadLik.ParamByName('LIK_ACABAM').AsString);

          If Not fEmptyStr(oleSheet.Cells[intLinha, 7].Text) Then
          Begin
            qryCadLik.ParamByName('LIK_FORM01').AsString := oleSheet.Cells[intLinha, 7].Text;
            qryCadLik.ParamByName('LIK_QTDC01').AsFloat  := fStrToFloatLiko(oleSheet.Cells[intLinha, 8].Text);
          End;
          If Not fEmptyStr(oleSheet.Cells[intLinha, 9].Text) Then
          Begin
            qryCadLik.ParamByName('LIK_FORM02').AsString := oleSheet.Cells[intLinha, 9].Text;
            qryCadLik.ParamByName('LIK_QTDC02').AsFloat  := fStrToFloatLiko(oleSheet.Cells[intLinha, 10].Text);
          End;
          If Not fEmptyStr(oleSheet.Cells[intLinha, 11].Text) Then
          Begin
            qryCadLik.ParamByName('LIK_FORM03').AsString := oleSheet.Cells[intLinha, 11].Text;
            qryCadLik.ParamByName('LIK_QTDC03').AsFloat  := fStrToFloatLiko(oleSheet.Cells[intLinha, 12].Text);
          End;
          If Not fEmptyStr(oleSheet.Cells[intLinha, 13].Text) Then
          Begin
            qryCadLik.ParamByName('LIK_FORM04').AsString := oleSheet.Cells[intLinha, 13].Text;
            qryCadLik.ParamByName('LIK_QTDC04').AsFloat  := fStrToFloatLiko(oleSheet.Cells[intLinha, 14].Text);
          End;
          If Not fEmptyStr(oleSheet.Cells[intLinha, 15].Text) Then
          Begin
            qryCadLik.ParamByName('LIK_FORM05').AsString := oleSheet.Cells[intLinha, 15].Text;
            qryCadLik.ParamByName('LIK_QTDC05').AsFloat  := fStrToFloatLiko(oleSheet.Cells[intLinha, 16].Text);
          End;
          If Not fEmptyStr(oleSheet.Cells[intLinha, 17].Text) Then
          Begin
            qryCadLik.ParamByName('LIK_FORM06').AsString := oleSheet.Cells[intLinha, 17].Text;
            qryCadLik.ParamByName('LIK_QTDC06').AsFloat  := fStrToFloatLiko(oleSheet.Cells[intLinha, 18].Text);
          End;

          For intForm := 1 To 6 Do
          Begin
            If qryCadLik.ParamByName('LIK_QTDC' + fStrZero(intForm, 2)).AsFloat <> 0 Then
              qryCadLik.ParamByName('LIK_QTDC' + fStrZero(intForm, 2)).AsFloat := qryCadLik.ParamByName('LIK_QTDC' + fStrZero(intForm, 2)).AsFloat * arrFator[intUnid];
          end;

          pRegistraProgresso(0, intLinha - 1, intUltLinha - 1);

          Try
            qryCadLik.ExecSQL;
          Except
            On E: EUniError Do
            Begin
              If E.ErrorCode = 1062 Then //DUPLICADO
                pRegistraAcao(Format('Fórmula %s já está cadastrada.',
                [oleSheet.Cells[intLinha, 3].Text + ' - ' + oleSheet.Cells[intLinha, 5].Text]))
              Else
                Raise;
            End;
          End;
        End;
      End;

      pRegistraAcao('Cadastro de fórmulas processado com sucesso!');

      Result := True;
    Finally
      If Assigned(qryCadLik) Then
        FreeAndNil(qryCadLik);

      If Not VarIsEmpty(olePlanilha) Then
      Begin
        olePlanilha.Quit;
        olePlanilha := Unassigned;
        oleSheet := Unassigned;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLikoNova.fProcessarCadLik]');
      Result := False;
    End;
  End;
end;

function TLikoDinamica.fStrToFloatLiko(strValorUnico: String): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',','),0);
end;

function fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  qryGen.SQL.Text := 'SELECT EMB_CODEMB, EMB_UNIDAD FROM LIK_CADEMB WHERE EMB_QTDEMB IN (900, 3600, 18000)';
  qryGen.Open;

  If qryGen.Locate('EMB_UNIDAD', strUniDes, []) Then
  Begin
    Result := qryGen.FieldByName('EMB_CODEMB').AsString;
  End
  Else
    Result := strCodEmbOrigem;

  FreeAndNil(qryGen);
end;

function fRetProximoCodSeq: Integer;
  Var
    qryGen: TUniQuery;
begin
   qryGen := fCriaQuery(nil);

  qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(LIK_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM LIK_CADLIK;';
   qryGen.Open;

  Result := qryGen.FieldByName('MAXIMO').AsInteger;
  FreeAndNil(qryGen);
end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM LIK_CADLIK WHERE LIK_CODIGO = :CODIGO ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODIGO').AsString := strCodigo;
    ExecSQL;
    Close;
  End;
end;

end.
