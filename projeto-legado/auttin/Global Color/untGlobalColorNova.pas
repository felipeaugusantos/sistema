unit untGlobalColorNova;

interface

uses untTintadeMaquina, Classes, Uni, Variants,  Dialogs, ADODB,
  DB, ComObj, Math;

Type
  TGlobalColorDinamica = class(TTintadeMaquina)
  private
    strPath: String;
    qryCadBas: TUniQuery;
    qryCadEmb: TUniQuery;
    qryCadCol: TUniQuery;
    qryCadUni: TUniQuery;

    blnTruncou: Boolean;

    function fProcessarCadGlo: Boolean;
    function fProcessarCadBas: Boolean;
    function fProcessarCadCol: Boolean;
    function fProcessarCadEmb: Boolean;

    function fStrToFloatGlobalColor(strValorUnico: String): Double;    

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

uses untFuncoesSimples, SysUtils,   StrUtils, untFuncTinta,
     untModuloTinta;



{ TGlobalColorDinamica }

constructor TGlobalColorDinamica.Create(AOwner: TComponent);
begin
  inherited;
  strPath := fGetConfTinta('GLO').fGet('TXTCOR');
  blnTruncou := False;

  qryCadBas := fCriaQuery(Self);
  qryCadBas.SQL.Add(' SELECT DISTINCT ');
  qryCadBas.SQL.Add('   AUTOINCREM, ');
  qryCadBas.SQL.Add('   BAS_BASE__, ');
  qryCadBas.SQL.Add('   BAS_DESCRI, ');
  qryCadBas.SQL.Add('   BAS_UNIDAD ');
  qryCadBas.SQL.Add(' FROM GLO_CADBAS ');
  qryCadBas.Open;

  qryCadEmb := fCriaQuery(Self);
  qryCadEmb.SQL.Add(' SELECT ');
  qryCadEmb.SQL.Add('   AUTOINCREM, ');
  qryCadEmb.SQL.Add('   EMB_CODEMB, ');
  qryCadEmb.SQL.Add('   EMB_UNIDAD ');
  qryCadEmb.SQL.Add(' FROM GLO_CADEMB ');
  qryCadEmb.Open;

  qryCadCol := fCriaQuery(Self);
  qryCadCol.SQL.Add(' SELECT ');
  qryCadCol.SQL.Add('   AUTOINCREM, ');
  qryCadCol.SQL.Add('   COL_CODCOL ');
  qryCadCol.SQL.Add(' FROM GLO_CADCOL ');
  qryCadCol.Open;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Add(' SELECT ');
  qryCadUni.SQL.Add('   EMB_CODEMB, ');
  qryCadUni.SQL.Add('   UNI_SIGUNI ');
  qryCadUni.SQL.Add(' FROM GLO_CADEMB ');
  qryCadUni.SQL.Add('   INNER JOIN CADUNI ');
  qryCadUni.SQL.Add('     ON EMB_UNIDAD = UNI_CODUNI ');
  qryCadUni.Open;
end;

destructor TGlobalColorDinamica.Destroy;
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
    arrFator: Array[1..3] Of Double = (1, 4, 20);

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryGen.Params.Count - 1 Do
    Begin
      qryGen.Params.Items[i].Value := Null;
    End;
  End;
begin
  qryGen := fCriaQuery(qryCadNfm);

  qryGen.SQL.Text := 'DELETE FROM GLO_CADGLO WHERE GLO_CODIGO = ' +
    QuotedStr(qryCadNfm.FieldByName('NFM_CODIGO').AsString);
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' INSERT INTO GLO_CADGLO ');
  qryGen.SQL.Add('             (GLO_CODSEQ, ');
  qryGen.SQL.Add('              GLO_CODEMP, ');
  qryGen.SQL.Add('              GLO_DESCRI, ');
  qryGen.SQL.Add('              GLO_CODIGO, ');
  qryGen.SQL.Add('              GLO_UNIDAD, ');
  qryGen.SQL.Add('              GLO_CODBAS, ');

  For intCont := 1 To 10 Do
  Begin
    qryGen.SQL.Add('              GLO_FORM' + fStrZero(intCont, 2) + ', ');
    qryGen.SQL.Add('              GLO_QTDC' + fStrZero(intCont, 2) + ', ');
  End;

  qryGen.SQL.Add('              AUTOINCREM, ');
  qryGen.SQL.Add('              GLO_CODEMB, ');
  qryGen.SQL.Add('              GLO_CODUNI, ');
  qryGen.SQL.Add('              GLO_PRODUT, ');
  qryGen.SQL.Add('              GLO_DTACAD, ');
  qryGen.SQL.Add('              GLO_MD5KEY) ');
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
  qryGen.SQL.Add('         :PRODUT, ');
  qryGen.SQL.Add('         :DTACAD, ');
  qryGen.SQL.Add('         :MD5KEY); ');

  blnGerUnids := qryCadNfm.FieldByName('NFM_GERUNI').AsInteger = 2;

  For intUnidade := 1 To 3 Do
  Begin
    Limpar;

    qryGen.ParamByName('CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
    qryGen.ParamByName('CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
    qryGen.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_DESPRO').AsString;
    qryGen.ParamByName('DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

    qryGen.ParamByName('UNIDAD').AsString :=
      IfThen(blnGerUnids, qryCadNfm.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnidade]);

    qryGen.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GLO_CADGLO', VS_strCodEmp);

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
      If Not fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
      Begin
        qryGen.ParamByName('FORM' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;
        qryGen.ParamByName('QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * Iif(blnGerUnids, 1, arrFator[intUnidade]);
      End;
    End;

    qryGen.ParamByName('MD5KEY').AsString := GetMD5(qryGen.ParamByName('DESCRI').AsString +
                                              qryGen.ParamByName('CODIGO').AsString +
                                              qryGen.ParamByName('UNIDAD').AsString +
                                              qryGen.ParamByName('CODBAS').AsString +
                                              qryGen.ParamByName('CODEMB').AsString +
                                              qryGen.ParamByName('CODUNI').AsString +
                                              qryGen.ParamByName('PRODUT').AsString);

    qryGen.ExecSQL;

    If blnGerUnids Then Break;
  End;

  Result := True;
end;

function TGlobalColorDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
    qryCadGlo: TUniQuery;
    intCont: Integer;
    intUnid: Integer;
    blnUnid: Boolean;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (1, 4, 20);
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'DELETE FROM GLO_CADGLO WHERE GLO_CODIGO IN (SELECT NFM_CODIGO FROM GLO_CADNFM);';
  qryGen.ExecSQL;

  qryGen.SQL.Clear;
  qryGen.SQL.Add(' SELECT * ');
  qryGen.SQL.Add(' FROM GLO_CADNFM ');
  qryGen.SQL.Add('   INNER JOIN GLO_CADBAS ');
  qryGen.SQL.Add('     ON NFM_CODBAS = BAS_BASE__ ');
  qryGen.SQL.Add('       AND NFM_DESPRO = BAS_DESCRI ');
  qryGen.SQL.Add('       AND NFM_UNIDAD = BAS_UNIDAD; ');
  qryGen.Open;
  qryGen.First;

  qryCadGlo := fCriaQuery(Self);
  qryCadGlo.SQL.Text := 'SELECT * FROM GLO_CADGLO WHERE FALSE';
  qryCadGlo.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('GLO_CADGLO', VS_strCodEmp);

  pRegistraAcao('Cadastrando novas formulas...');
  While Not qryGen.Eof Do
  Begin
    blnUnid := qryGen.FieldByName('NFM_GERUNI').AsInteger <> 1;


    For intUnid := 1 To 3 Do
    Begin
      qryCadGlo.Insert;

      qryCadGlo.FieldByName('GLO_CODSEQ').AsString := fStrZero(fRetProximoCodSeq, 6);
      qryCadGlo.FieldByName('GLO_CODEMP').AsString := VS_strCodEmp;
      qryCadGlo.FieldByName('GLO_DESCRI').AsString := qryGen.FieldByName('NFM_DESCRI').AsString;
      qryCadGlo.FieldByName('GLO_CODIGO').AsString := qryGen.FieldByName('NFM_CODIGO').AsString;
      qryCadGlo.FieldByName('GLO_UNIDAD').AsString := IfThen(blnUnid, qryGen.FieldByName('NFM_UNIDAD').AsString, arrUnid[intUnid]);
      qryCadGlo.FieldByName('GLO_CODBAS').AsString := qryGen.FieldByName('NFM_CODBAS').AsString;
      qryCadGlo.FieldByName('GLO_PRODUT').AsString := qryGen.FieldByName('NFM_DESPRO').AsString;

      For intCont := 1 To 10 Do
      Begin

        If fEmptyStr(qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString) Then
          Break;

        qryCadGlo.FieldByName('GLO_FORM' + fStrZero(intCont, 2)).AsString :=
          qryGen.FieldByName('NFM_FORM' + fStrZero(intCont, 2)).AsString;

        qryCadGlo.FieldByName('GLO_QTDC' + fStrZero(intCont, 2)).AsFloat :=
          qryGen.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat * IIF(blnUnid, 1, arrFator[intUnid]);
      End;

      qryCadGlo.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GLO_CADGLO', VS_strCodEmp);

      If blnUnid Then
      Begin
        qryCadGlo.FieldByName('GLO_CODEMB').AsString := qryGen.FieldByName('NFM_CODEMB').AsString;
      End
      Else
      Begin
        qryCadGlo.FieldByName('GLO_CODEMB').AsString :=
          fRetCodEmbalagem(qryGen.FieldByName('NFM_CODEMB').AsString, arrUnid[intUnid]);
      End;

      qryCadGlo.FieldByName('GLO_CODUNI').AsString := qryCadGlo.FieldByName('GLO_UNIDAD').AsString;
      qryCadGlo.FieldByName('GLO_MD5KEY').AsString := GetMD5(qryCadGlo.FieldByName('GLO_DESCRI').AsString +
                                                        qryCadGlo.FieldByName('GLO_CODIGO').AsString +
                                                        qryCadGlo.FieldByName('GLO_UNIDAD').AsString +
                                                        qryCadGlo.FieldByName('GLO_CODBAS').AsString +
                                                        qryCadGlo.FieldByName('GLO_CODEMB').AsString +
                                                        qryCadGlo.FieldByName('GLO_CODUNI').AsString +
                                                        qryCadGlo.FieldByName('GLO_PRODUT').AsString);

      qryCadGlo.Post;

      If blnUnid Then Break;
    End;
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  FreeAndNil(qryGen);
  Result := True;
end;

function TGlobalColorDinamica.fProcessarArquivos(intOpcao: Integer): Boolean;
begin
  Try
    Result := True;
    Case intOpcao of
      0: Result := fProcessarCadCol and fProcessarCadEmb;
      1: Result := fProcessarCadBas;
      2: Result := fProcessarCadGlo;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TGlobalColorDinamica.fProcessarArquivos');
    End;
  end;
end;

function TGlobalColorDinamica.fProcessarCadBas: Boolean;
var
  qryCadbas: TUniQuery;
  intUnid, intProdut, intProc, intBase: Integer;
Const
  arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
  arrProdut: Array[1..15] Of String = ('ACRILICO FOSCO PREMIUM',
    'ESMALTE SINTETICO ACETINADO PREMIUM',
    'ESMALTE SINTETICO BRILHANTE PREMIUM',
    'ACRILICO SEMI BRILHO PREMIUM',
    'ACRILICO ACETINADO PREMIUM',
    'ESMALTE BRILHANTE BASE AGUA',
    'ESMALTE ACETINADO BASE AGUA',
    'LATEX VINIL ACRILICO ECONOMICO',
    'ESMALTE SINTETICO STANDARD',
    'ESMALTE SINTETICO SECAGEM RAPIDA',
    'ACRILICO ULTRA STANDARD',
    'GEL ENVELHECEDOR',
    'TEXTURA ACRILICA LISA',
    'TEXTURA ACRILICA RUSTICA',
    'TEXTURA ACRILICA DESENHO');
begin
  Result := False;
  Try
    qryCadBas := fCriaQuery;
    Try
      qryCadBas.SQL.Text := 'SELECT * FROM GLO_CADBAS';
      qryCadBas.Open;

      pRegistraAcao('Processando cadastro de bases...');

      intProc := 0;
      For intBase := 1 to 3 Do
      Begin
        For intUnid := 1 to 3 Do
        Begin
          For intProdut := 1 to 15 Do
          Begin
            inc(intProc);
            qryCadbas.Insert;
            qryCadbas.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('GLO_CADBAS', VS_strCodEmp);
            qryCadbas.FieldByName('BAS_BASE__').AsInteger := intBase;
            qryCadbas.FieldByName('BAS_DESCRI').AsString  := arrProdut[intProdut];
            qryCadbas.FieldByName('BAS_UNIDAD').AsString  := arrUnid[intUnid];
            qryCadbas.FieldByName('BAS_CODEMP').AsString  := VS_strCodEmp;
            qryCadbas.FieldByName('BAS_PRECUS').AsFloat   := 0.00;
            qryCadbas.FieldByName('BAS_PREVEN').AsFloat   := 0.00;
            qryCadbas.FieldByName('BAS_MARGEM').AsFloat   := 0.00;
            qryCadbas.FieldByName('BAS_CODITE').Value     := Null;
            Try
              qryCadbas.Post;
            Except
              On E: EUniError Do
              Begin
                If E.ErrorCode = 1062 Then //DUPLICADO
                Begin
                  pRegistraAcao(Format('Base %s já está cadastrada',
                  [arrProdut[intProdut]]));
                  qryCadbas.Cancel;
                End
                Else
                Raise;
              End;
            End;
            pRegistraProgresso(0, intProc, 135);
          end;
        End;
      End;
      pRegistraAcao('Cadastro de bases processado com sucesso!');
      Result := True;
    Finally
      FreeAndNil(qryCadbas);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGlobalColorNova.fProcessarCadBas]');
      Result := False;
    End;
  End;
end;

function TGlobalColorDinamica.fProcessarCadCol: Boolean;
  Var
    qryCadCol: TUniQuery;
    intCont: Integer;
  Const
    arrCod: Array[1..13] Of String = ('AXX', 'B', 'C', 'L', 'R', 'I', 'T', 'E', 'V', 'KX', 'F', 'D', 'AXN');
    arrNom: Array[1..13] Of String = ('AMARELO', 'PRETO', 'AMARELO ÓXIDO', 'RAW UMBER', 'VERMELHO', 'MARROM ÓXIDO',
       'AMARELO', 'AZUL', 'MAGENTA', 'BRANCO', 'VERMELHO ÓXIDO', 'VERDE', 'AMARELO');
begin
  Result := False;
  Try
    qryCadCol := fCriaQuery();
    Try
      qryCadCol.SQL.Add(' INSERT INTO GLO_CADCOL ');
      qryCadCol.SQL.Add('             (AUTOINCREM, ');
      qryCadCol.SQL.Add('              COL_CODCOL, ');
      qryCadCol.SQL.Add('              COL_DESCRI, ');
      qryCadCol.SQL.Add('              COL_CODEMP) ');
      qryCadCol.SQL.Add(' VALUES (:AUTOINCREM, ');
      qryCadCol.SQL.Add('         :COL_CODCOL, ');
      qryCadCol.SQL.Add('         :COL_DESCRI, ');
      qryCadCol.SQL.Add('         :COL_CODEMP);');

      pRegistraAcao('Processando cadastro de colorantes...');

      For intCont := 1 to 13 Do
      Begin
        qryCadCol.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GLO_CADCOL', VS_strCodEmp);
        qryCadCol.ParamByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryCadCol.ParamByName('COL_CODCOL').AsString := arrCod[intCont];
        qryCadCol.ParamByName('COL_DESCRI').AsString := arrNom[intCont];

        Try
          qryCadCol.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then //DUPLICADO
              pRegistraAcao(Format('Colorante %s já está cadastrado.',
              [arrCod[intCont]]))
            Else
              Raise;
          End;
        End;
        pRegistraProgresso(1, intCont, 13);
      End;

      pRegistraAcao('Cadastro de colorantes processado com sucesso!');

      Result := True;
    Finally
      FreeAndNil(qryCadCol);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGlobalColorNova.fProcessarCadCol]');
      Result := False;
    End;
  End;
end;

function TGlobalColorDinamica.fProcessarCadEmb: Boolean;
  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM GLO_CADEMB';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  Var
    qryCadEmb: TUniQuery;
    intUnid: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrQtde: Array[1..3] Of Double = (810, 3240, 16200);
begin
  Try
    pDeletaRegistros;

    qryCadEmb := fCriaQuery();
    Try
      qryCadEmb.SQL.Add(' INSERT INTO GLO_CADEMB ');
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

      For intUnid := 1 to 3 Do
      Begin
        qryCadEmb.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('GLO_CADEMB', VS_strCodEmp);
        qryCadEmb.ParamByName('EMB_CODEMB').AsString := IntToStr(intUnid);
        qryCadEmb.ParamByName('EMB_CODEMP').AsString := VS_strCodEmp;
        qryCadEmb.ParamByName('EMB_QTDEMB').AsFloat  := arrQtde[intUnid];
        qryCadEmb.ParamByName('EMB_UNIDAD').AsString := arrUnid[intUnid];

        qryCadEmb.ExecSQL;
        pRegistraProgresso(1, intUnid, 3);
      End;
    Finally
      FreeAndNil(qryCadEmb);
    End;

    pRegistraAcao('Cadastro de embalagens processado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TGlobalColorNova.fProcessarCadEmb]');
      Result := False;
    End;
  End;
end;

function TGlobalColorDinamica.fProcessarCadGlo: Boolean;
  Var
    olePlanilha, oleSheet: OleVariant;
    intLinha, intUltLinha: Integer;
    blnFimPlan: Boolean;
    qryCadGlo: TUniQuery;
    intForm: Integer;
    intCodSeq,
    intUnid,
    intFolha: Integer;
  Const
    arrUnid: Array[1..3] Of String = ('LT', 'GL', 'LA');
    arrFator: Array[1..3] Of Double = (0.81, 3.24, 16.2);
    arrProdut: Array[1..15] Of String = ('ACRILICO FOSCO PREMIUM',
      'ESMALTE SINTETICO ACETINADO PREMIUM',
      'ESMALTE SINTETICO BRILHANTE PREMIUM',
      'ACRILICO SEMI BRILHO PREMIUM',
      'ACRILICO ACETINADO PREMIUM',
      'ESMALTE BRILHANTE BASE AGUA',
      'ESMALTE ACETINADO BASE AGUA',
      'LATEX VINIL ACRILICO ECONOMICO',
      'ESMALTE SINTETICO STANDARD',
      'ESMALTE SINTETICO SECAGEM RAPIDA',
      'ACRILICO ULTRA STANDARD',
      'GEL ENVELHECEDOR',
      'TEXTURA ACRILICA LISA',
      'TEXTURA ACRILICA RUSTICA',
      'TEXTURA ACRILICA DESENHO');

  function fRetProximoCodSeq: Integer;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(GLO_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM GLO_CADGLO;';
    qryGen.Open;

    Result := qryGen.FieldByName('MAXIMO').AsInteger;
    FreeAndNil(qryGen);
  end;

  procedure pDeletaRegistros;
    Var
      qryGen: TUniQuery;
  begin
    qryGen := fCriaQuery(nil);
    qryGen.SQL.Text := 'DELETE FROM GLO_CADGLO';
    qryGen.ExecSQL;
    FreeAndNil(qryGen);
  end;

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 0 To qryCadGlo.Params.Count - 1 Do
    Begin
      qryCadGlo.Params.Items[i].Value := Null;
    End;
  End;
begin
  Try
    Result := False;
    pDeletaRegistros;

    olePlanilha := CreateOleObject('Excel.Application');
    qryCadGlo := fCriaQuery();
    Try
      olePlanilha.Visible := False;
      olePlanilha.WorkBooks.Open(strPath);

      pRegistraAcao('Processando cadastro de Fórmulas...');

      qryCadGlo.SQL.Add(' INSERT INTO GLO_CADGLO ');
      qryCadGlo.SQL.Add('             (GLO_CODSEQ, ');
      qryCadGlo.SQL.Add('              GLO_CODEMP, ');
      qryCadGlo.SQL.Add('              GLO_DESCRI, ');
      qryCadGlo.SQL.Add('              GLO_CODIGO, ');
      qryCadGlo.SQL.Add('              GLO_UNIDAD, ');
      qryCadGlo.SQL.Add('              GLO_CODBAS, ');
      qryCadGlo.SQL.Add('              GLO_CODEMB, ');
      qryCadGlo.SQL.Add('              GLO_CODUNI, ');
      qryCadGlo.SQL.Add('              GLO_PRODUT, ');
      qryCadGlo.SQL.Add('              GLO_MD5KEY, ');

      For intForm := 1 To 4 Do
      Begin
        qryCadGlo.SQL.Add('            GLO_FORM' + fStrZero(intForm, 2) + ', ');
        qryCadGlo.SQL.Add('            GLO_QTDC' + fStrZero(intForm, 2) + ', ');
      End;

      qryCadGlo.SQL.Add('              AUTOINCREM) ');
      qryCadGlo.SQL.Add(' VALUES (:GLO_CODSEQ, ');
      qryCadGlo.SQL.Add('         :GLO_CODEMP, ');
      qryCadGlo.SQL.Add('         :GLO_DESCRI, ');
      qryCadGlo.SQL.Add('         :GLO_CODIGO, ');
      qryCadGlo.SQL.Add('         :GLO_UNIDAD, ');
      qryCadGlo.SQL.Add('         :GLO_CODBAS, ');
      qryCadGlo.SQL.Add('         :GLO_CODEMB, ');
      qryCadGlo.SQL.Add('         :GLO_CODUNI, ');
      qryCadGlo.SQL.Add('         :GLO_PRODUT, ');
      qryCadGlo.SQL.Add('         :GLO_MD5KEY, ');

      For intForm := 1 To 4 Do
      Begin
        qryCadGlo.SQL.Add('       :GLO_FORM' + fStrZero(intForm, 2) + ', ');
        qryCadGlo.SQL.Add('       :GLO_QTDC' + fStrZero(intForm, 2) + ', ');
      End;

      qryCadGlo.SQL.Add('         :AUTOINCREM); ');

      intCodSeq := 0;      

      For intFolha := 1 to 15 do
      Begin
        oleSheet := olePlanilha.WorkSheets[intFolha];

        intUltLinha := 3;
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

        For intLinha := 3 to intUltLinha do
        Begin
          for intUnid := 1 to 3 Do
          Begin
            Limpar;

            Inc(intCodSeq);
            qryCadGlo.ParamByName('AUTOINCREM').AsString  := fRetAutoIncrem('GLO_CADGLO', VS_strCodEmp);
            qryCadGlo.ParamByName('GLO_CODSEQ').AsString  := fStrZero(intCodSeq, 6);
            qryCadGlo.ParamByName('GLO_CODEMP').AsString  := VS_strCodEmp;
            qryCadGlo.ParamByName('GLO_DESCRI').AsString  := AnsiUpperCase(oleSheet.Cells[intLinha, 3].Text);
            qryCadGlo.ParamByName('GLO_CODIGO').AsString  := oleSheet.Cells[intLinha, 1].Text;
            qryCadGlo.ParamByName('GLO_UNIDAD').AsString  := arrUnid[intUnid];
            qryCadGlo.ParamByName('GLO_CODUNI').AsString  := arrUnid[intUnid];
            qryCadGlo.ParamByName('GLO_CODBAS').AsString  := oleSheet.Cells[intLinha, 2].Text;
            qryCadGlo.ParamByName('GLO_CODEMB').AsString  := fRetCodEmbalagem('2',arrUnid[intUnid]);
            qryCadGlo.ParamByName('GLO_PRODUT').AsString  := arrProdut[intFolha];
            qryCadGlo.ParamByName('GLO_MD5KEY').AsString  := GetMD5(qryCadGlo.ParamByName('GLO_DESCRI').AsString +
                                                               qryCadGlo.ParamByName('GLO_CODIGO').AsString +
                                                               qryCadGlo.ParamByName('GLO_UNIDAD').AsString +
                                                               qryCadGlo.ParamByName('GLO_CODBAS').AsString +
                                                               qryCadGlo.ParamByName('GLO_CODEMB').AsString +
                                                               qryCadGlo.ParamByName('GLO_CODUNI').AsString +
                                                               qryCadGlo.ParamByName('GLO_PRODUT').AsString);

            {*******************************************}
            {* NA PLANILHA TEM UMA COLUNA COM INTEIRO  *}
            {* E OUTRA COM A PARTE FRACIONADA DA ONÇA  *}
            {****************************************NC*}
            If Not fEmptyStr(oleSheet.Cells[intLinha, 4].Text) Then
            Begin
              qryCadGlo.ParamByName('GLO_FORM01').AsString := oleSheet.Cells[intLinha, 4].Text;
              qryCadGlo.ParamByName('GLO_QTDC01').AsFloat  := RoundTo(((fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 5].Text) * 29.574) +
                (fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 6].Text) * 0.616125)) * arrFator[intUnid] / 3.24, -4);
            End;
            If Not fEmptyStr(oleSheet.Cells[intLinha, 7].Text) Then
            Begin
              qryCadGlo.ParamByName('GLO_FORM02').AsString := oleSheet.Cells[intLinha, 7].Text;
              qryCadGlo.ParamByName('GLO_QTDC02').AsFloat  := RoundTo(((fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 8].Text) * 29.574) +
                (fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 9].Text) * 0.616125)) * arrFator[intUnid] / 3.24, -4);
            End;
            If Not fEmptyStr(oleSheet.Cells[intLinha, 10].Text) Then
            Begin
              qryCadGlo.ParamByName('GLO_FORM03').AsString := oleSheet.Cells[intLinha, 10].Text;
              qryCadGlo.ParamByName('GLO_QTDC03').AsFloat  := RoundTo(((fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 11].Text) * 29.574) +
                (fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 12].Text) * 0.616125)) * arrFator[intUnid] / 3.24, -4);
            End;
            If Not fEmptyStr(oleSheet.Cells[intLinha, 13].Text) Then
            Begin
              qryCadGlo.ParamByName('GLO_FORM04').AsString := oleSheet.Cells[intLinha, 13].Text;
              qryCadGlo.ParamByName('GLO_QTDC04').AsFloat  := RoundTo(((fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 14].Text) * 29.574) +
                (fStrToFloatGlobalColor(oleSheet.Cells[intLinha, 15].Text) * 0.616125)) * arrFator[intUnid] / 3.24, -4);
            End;

            pRegistraProgresso(0, intCodSeq, (intUltLinha - 2) * 15 * 3);

            Try
              qryCadGlo.ExecSQL;
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
      End;

      pRegistraAcao('Cadastro de fórmulas processado com sucesso!');

      Result := True;
    Finally
      If Assigned(qryCadGlo) Then
        FreeAndNil(qryCadGlo);

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
      pMensagensErro(E.Message, '[TGlobalColorNova.fProcessarCadGlo]');
      Result := False;
    End;
  End;
end;

function TGlobalColorDinamica.fStrToFloatGlobalColor(strValorUnico: String): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',','),0);
end;

function fRetCodEmbalagem(strCodEmbOrigem,
  strUniDes: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  qryGen.SQL.Text := 'SELECT EMB_CODEMB, EMB_UNIDAD FROM GLO_CADEMB WHERE EMB_QTDEMB IN (810, 3240, 16200)';
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

  qryGen.SQL.Text := 'SELECT IFNULL(MAX(CONVERT(GLO_CODSEQ,SIGNED)), 0) + 1 AS MAXIMO FROM GLO_CADGLO;';
   qryGen.Open;

  Result := qryGen.FieldByName('MAXIMO').AsInteger;
  FreeAndNil(qryGen);
end;

procedure pDeletaNovaFormula(strCodigo: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'DELETE FROM GLO_CADGLO WHERE GLO_CODIGO = :CODIGO ';

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
