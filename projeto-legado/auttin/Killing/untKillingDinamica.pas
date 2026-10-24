unit untKillingDinamica;

interface

uses
  untTintadeMaquina, Classes, ADODB, Uni, 
  untIConfTinta, InterBaseUniProvider;

Type


  TKillingDinamica = class(TTintadeMaquina)
  private
    strPath: String;
    conf: IConfTinta;
    function fProcessarCadBas: Boolean;
    function fProcessarCadCol: Boolean;
    function fProcessarCadKil: Boolean;

    function fCriaAdoQuery(): TADOQuery;
  public
    function fGravarNovasFormulas: Boolean; override;
    function fProcessarArquivos: Boolean;
    constructor Create(AOwner: TComponent); override;
    class function fGravarNovaFormula(qryCadNfm: TUniQuery): Boolean;
    class procedure pDeletaNovaFormulaDinamica(strCodPro: String);

  End;

  TKillingDinamicaFireBird = class(TTintadeMaquina)
  private
    conf: IConfTinta;
    Provider: TInterbaseUniProvider;
    function fProcessarCadBas: Boolean;
    function fProcessarCadCol: Boolean;
    function fProcessarCadKil: Boolean;

    function fConnectionFdb : TUniConnection;
  public
    function fGravarNovasFormulas: Boolean; override;
    function fProcessarArquivos: Boolean;
    constructor Create(AOwner: TComponent); override;
  End;

implementation

uses SysUtils, untFuncTinta, untFuncoesSimples, Variants, DB;



{ TKillingDinamica }

constructor TKillingDinamica.Create(AOwner: TComponent);
begin
  inherited;
  NomeTinta := 'Killing';
  conf      := fGetConfTinta('KIL');
  strPath := conf.fGet('PATKIL'); //fArqIniTinta(0, 'KILLING', 'PATKIL', '');
end;


function TKillingDinamica.fCriaAdoQuery: TADOQuery;
begin
  Result := TADOQuery.Create(Nil);
  Result.ConnectionString :=
      'Provider=MSDASQL.1;Password=camjgrifo;Persist Security Info=True;User ID=Admin;Extended Properties="DBQ=' +
      strPath +
      ';DefaultDir=' +
      ExtractFileDir(strPath) +
      ';Driver={Microsoft Access Driver (*.mdb, *.accdb)};DriverId=25;FIL=MS Access;MaxBufferSize=2048;MaxScanRows=8;PageTimeout=5;SafeTransactions=0;Threads=3;UID=admin;UserCommitSync=Yes;";Initial Catalog=' +
      strPath;
end;

class function TKillingDinamica.fGravarNovaFormula(
  qryCadNfm: TUniQuery): Boolean;
  Var
    qryGen: TUniQuery;
    qryCadBas: TUniQuery;
    intForm: Integer;
begin
  qryGen := fCriaQuery(Nil);

  qryGen.SQL.Text := 'DELETE FROM KILD_CADKIL WHERE KIL_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
  qryGen.ExecSQL;
  qryGen.SQL.Clear;

  qryGen.SQL.Add(' INSERT INTO KILD_CADKIL ');
  qryGen.SQL.Add('             (AUTOINCREM, ');
  qryGen.SQL.Add('              KIL_CODCOR, ');
  qryGen.SQL.Add('              KIL_NOMCOR, ');
  qryGen.SQL.Add('              KIL_DESCRI, ');
  qryGen.SQL.Add('              KIL_REFERE, ');
  qryGen.SQL.Add('              KIL_CODBAS, ');
  qryGen.SQL.Add('              KIL_CODUNI, ');
  qryGen.SQL.Add('              KIL_CODNFM, ');
  qryGen.SQL.Add('              KIL_DTACAD, ');

  For intForm := 1 To 20 Do
  Begin
    qryGen.SQL.Add('              KIL_FORM' + fStrZero(intForm, 2) + ', ');
    qryGen.SQL.Add('              KIL_QTDB' + fStrZero(intForm, 2) + ', ');
  End;

  qryGen.SQL.Add('              KIL_CODFML) ');
  qryGen.SQL.Add(' VALUES (:AUTOINCREM, ');
  qryGen.SQL.Add('         :KIL_CODCOR, ');
  qryGen.SQL.Add('         :KIL_NOMCOR, ');
  qryGen.SQL.Add('         :KIL_DESCRI, ');
  qryGen.SQL.Add('         :KIL_REFERE, ');
  qryGen.SQL.Add('         :KIL_CODBAS, ');
  qryGen.SQL.Add('         :KIL_CODUNI, ');
  qryGen.SQL.Add('         :KIL_CODNFM, ');
  qryGen.SQL.Add('         :KIL_DTACAD, ');

  For intForm := 1 To 20 Do
  Begin
    qryGen.SQL.Add('         :KIL_FORM' + fStrZero(intForm, 2) + ', ');
    qryGen.SQL.Add('         :KIL_QTDB' + fStrZero(intForm, 2) + ', ');
  End;

  qryGen.SQL.Add('         :KIL_CODFML); ');

  qryCadBas := fCriaQuery();

  qryCadBas.SQL.Add(' SELECT DISTINCT ');
  qryCadBas.SQL.Add('   BAS_CODUNI, ');
  qryCadBas.SQL.Add('   BAS_EMBALA ');
  qryCadBas.SQL.Add(' FROM KILD_CADBAS ');
  qryCadBas.SQL.Add(' WHERE BAS_CODFML = :CODFML ');
  qryCadBas.SQL.Add('     AND BAS_CODBAS = :CODBAS ');
  qryCadBas.SQL.Add(' ORDER BY BAS_CODUNI; ');

  qryCadBas.ParamByName('CODFML').AsString := qryCadNfm.FieldByName('NFM_CODFML').AsString;
  qryCadBas.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
  qryCadBas.Open;

  qryGen.ParamByName('KIL_CODCOR').AsString := 'ESP';
  qryGen.ParamByName('KIL_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
  qryGen.ParamByName('KIL_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
  qryGen.ParamByName('KIL_DESCRI').AsString := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
  qryGen.ParamByName('KIL_REFERE').AsString := qryCadNfm.FieldByName('NFM_REFERE').AsString;
  qryGen.ParamByName('KIL_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('KIL_CODFML').AsString := qryCadNfm.FieldByName('NFM_CODFML').AsString;
  qryGen.ParamByName('KIL_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;
  qryCadBas.First;

  While Not qryCadBas.Eof Do
  Begin
    qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('KILD_CADKIL', VS_strCodEmp);
    qryGen.ParamByName('KIL_CODUNI').AsString := qryCadBas.FieldByName('BAS_CODUNI').AsString;

    For intForm := 1 To 20 Do
    Begin
      If fEmptyStr(qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intForm, 2)).AsString) Then
        Break;

      qryGen.ParamByName('KIL_FORM' + fStrZero(intForm, 2)).AsString := qryCadNfm.FieldByName('NFM_FORM' + fStrZero(intForm, 2)).AsString;
      qryGen.ParamByName('KIL_QTDB' + fStrZero(intForm, 2)).AsFloat := (qryCadNfm.FieldByName('NFM_QTDB' + fStrZero(intForm, 2)).AsFloat
                                                * qryCadBas.FieldByName('BAS_EMBALA').AsFloat / 810) / 4;
    End;
    
    qryGen.ExecSQL;
    qryCadBas.Next;
  End;

  FreeAndNil(qryGen);
  FreeAndNil(qryCadBas);
  Result := True;
end;

function TKillingDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT * FROM KILD_CADNFM';
  qryGen.Open;

  pRegistraAcao('Processando cadastro de novas fórmulas...');
  While Not qryGen.Eof Do
  Begin
    fGravarNovaFormula(qryGen);
    qryGen.Next;
    pRegistraProgresso(0, qryGen.RecNo, qryGen.RecordCount);
  End;
  pRegistraAcao('Cadastro de novas fórmulas processando com sucesso!');
  FreeAndNil(qryGen);
  Result := True;
end;


function TKillingDinamica.fProcessarArquivos: Boolean;
begin
  Result := false;

  If fProcessarCadCol Then
  begin
    if fProcessarCadBas then
      Result := fProcessarCadKil
  end;
end;

function TKillingDinamica.fProcessarCadBas: Boolean;
  Var
    qryAdoCadBas : TADOQuery;
    qryCadBas    : TUniQuery;
begin
  Try
    qryAdoCadBas := fCriaAdoQuery();

    qryAdoCadBas.SQL.Add(' SELECT DISTINCT ');
    qryAdoCadBas.SQL.Add('   ITEM.CODIGO, ');
    qryAdoCadBas.SQL.Add('   ITEM.DESCRICAO, ');
    qryAdoCadBas.SQL.Add('   BASES.BASE, ');
    qryAdoCadBas.SQL.Add('   CONTAINER.CONTAINER, ');
    qryAdoCadBas.SQL.Add('   CONTAINER.FATOR_CONVERCAO ');
    qryAdoCadBas.SQL.Add(' FROM ITEM, ');
    qryAdoCadBas.SQL.Add('   BASES, ');
    qryAdoCadBas.SQL.Add('   CONTAINER ');
    qryAdoCadBas.SQL.Add(' WHERE ITEM.CODIGO = BASES.ITEM_BASE ');
    qryAdoCadBas.SQL.Add('     AND BASES.ITEM = CONTAINER.ITEM ');
    qryAdoCadBas.Open;

    qryCadBas := fCriaQuery();
    qryCadBas.SQL.Add(' INSERT INTO KILD_CADBAS ');
    qryCadBas.SQL.Add('             (BAS_CODFML, ');
    qryCadBas.SQL.Add('              BAS_CODBAS, ');
    qryCadBas.SQL.Add('              BAS_CODUNI, ');
    qryCadBas.SQL.Add('              BAS_EMBALA, ');
    qryCadBas.SQL.Add('              BAS_DESCRI, ');
    qryCadBas.SQL.Add('              AUTOINCREM) ');
    qryCadBas.SQL.Add(' VALUES (:BAS_CODFML, ');
    qryCadBas.SQL.Add('         :BAS_CODBAS, ');
    qryCadBas.SQL.Add('         :BAS_CODUNI, ');
    qryCadBas.SQL.Add('         :BAS_EMBALA, ');
    qryCadBas.SQL.Add('         :BAS_DESCRI, ');
    qryCadBas.SQL.Add('         :AUTOINCREM); ');


    pRegistraAcao('Processando cadastro de bases...');
    While Not qryAdoCadBas.Eof Do
    Begin
      qryCadBas.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('KILD_CADBAS',  VS_strCodEmp);
      qryCadBas.ParamByName('BAS_CODFML').AsString := qryAdoCadBas.FieldByName('CODIGO').AsString;
      qryCadBas.ParamByName('BAS_CODBAS').AsString := qryAdoCadBas.FieldByName('BASE').AsString;
      qryCadBas.ParamByName('BAS_CODUNI').AsString := qryAdoCadBas.FieldByName('CONTAINER').AsString;
      qryCadBas.ParamByName('BAS_DESCRI').AsString := qryAdoCadBas.FieldByName('DESCRICAO').AsString;
      qryCadBas.ParamByName('BAS_EMBALA').AsFloat  := qryAdoCadBas.FieldByName('FATOR_CONVERCAO').AsFloat * 1000;

      Try
        qryCadBas.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('A base %s - %s - %s - %s já está cadastrado',
            [qryAdoCadBas.FieldByName('CODIGO').AsString,
            qryAdoCadBas.FieldByName('BASE').AsString,
            qryAdoCadBas.FieldByName('CONTAINER').AsString,
            qryAdoCadBas.FieldByName('DESCRICAO').AsString]))
          Else
            Raise;
        End;
      End;

      qryAdoCadBas.Next;
      pRegistraProgresso(0, qryAdoCadBas.RecNo, qryAdoCadBas.RecordCount);
    End;
    pRegistraAcao('Cadastro de bases processado com sucesso!');

    FreeAndNil(qryAdoCadBas);
    FreeAndNil(qryCadBas);
  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
  Result := True;
end;

function TKillingDinamica.fProcessarCadCol: Boolean;
  Var
    qryAdoCadCol: TADOQuery;
    qryCadCol: TUniQuery;
    blnError : Boolean;
begin
  blnError := false;
  Result   := false;
  Try
    qryAdoCadCol := fCriaAdoQuery();

    qryAdoCadCol.SQL.Add(' SELECT ');
    qryAdoCadCol.SQL.Add('   CODIGO, ');
    qryAdoCadCol.SQL.Add('   DESCRICAO ');
    qryAdoCadCol.SQL.Add(' FROM ITEM ');
    qryAdoCadCol.SQL.Add(' WHERE OID_TIPO_ITEM = 1 ');

    Try
      qryAdoCadCol.Open;
    Except On E : Exception Do // Veirificar se o ms access (MS Office) está instalado.
      begin
        blnError := true;
        fMensagem('', 'Não foi possível realizar a conexão com o arquivo. ' + #13 +
          ' Verifique se o driver de conexão está instalado corretamente.', ['OK']);
      end;
    End;

    qryCadCol := fCriaQuery();
    qryCadCol.SQL.Add(' INSERT INTO KILD_CADCOL ');
    qryCadCol.SQL.Add('             (AUTOINCREM, ');
    qryCadCol.SQL.Add('              COL_CODCOL, ');
    qryCadCol.SQL.Add('              COL_DESCRI) ');
    qryCadCol.SQL.Add(' VALUES (:AUTOINCREM, ');
    qryCadCol.SQL.Add('         :COL_CODCOL, ');
    qryCadCol.SQL.Add('         :COL_DESCRI); ');

    pRegistraAcao('Processando cadastro de colorantes...');
    While Not qryAdoCadCol.Eof Do
    Begin
      qryCadCol.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('KILD_CADCOL', VS_strCodEmp);
      qryCadCol.ParamByName('COL_CODCOL').AsString := qryAdoCadCol.FieldByName('CODIGO').AsString;
      qryCadCol.ParamByName('COL_DESCRI').AsString := qryAdoCadCol.FieldByName('DESCRICAO').AsString;

      Try
        qryCadCol.ExecSQL;
      Except
        On E: EUniError Do
        Begin
          blnError := true;

          If E.ErrorCode = 1062 Then //DUPLICADO
            pRegistraAcao(Format('O Colorante %s - %s já está cadastrado',
            [qryAdoCadCol.FieldByName('CODIGO').AsString, qryAdoCadCol.FieldByName('DESCRICAO').AsString]))
          Else
            Raise;
        End;
      End;
      qryAdoCadCol.Next;
      pRegistraProgresso(0, qryAdoCadCol.RecNo, qryAdoCadCol.RecordCount);
    End;

    if not blnError then
    begin
      Result := true;
      pRegistraAcao('Cadastro de colorantes processado com sucesso!')
    end
    else
      pRegistraAcao('Erro ao tentar processar o arquivo!');


    FreeAndNil(qryAdoCadCol);
    FreeAndNil(qryAdoCadCol);

  Except
    Raise;
  End;
end;

function TKillingDinamica.fProcessarCadKil: Boolean;
  Var
    qryAdoCadKil: TADOQuery;
    qryAdoCadBas: TADOQuery;
    qryCadKil: TUniQuery;
    intForm: Integer;
    strCodCor: String;
    intPosRecNo: Integer;
    blnProximo: Boolean;    

  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 1 To 20 Do
    Begin
      qryCadKil.ParamByName('KIL_FORM' + fStrZero(i, 2)).Value := Null;
      qryCadKil.ParamByName('KIL_QTDB' + fStrZero(i, 2)).Value := Null;
    End;
  End;
begin
  qryAdoCadKil := fCriaAdoQuery();
  qryCadKil := fCriaQuery();

  qryAdoCadKil.SQL.Add(' SELECT DISTINCT ');
  qryAdoCadKil.SQL.Add('   CORES.ITEM, ');
  qryAdoCadKil.SQL.Add('   CORES.COR, ');
  qryAdoCadKil.SQL.Add('   FORMULA_COR.OID_TIPO_ITEM, ');
  qryAdoCadKil.SQL.Add('   FORMULA_COR.QTD_ONCAS, ');
  qryAdoCadKil.SQL.Add('   FORMULA_COR.CD_MATERIAL, ');
  qryAdoCadKil.SQL.Add('   ITEM.DESCRICAO ');
  qryAdoCadKil.SQL.Add(' FROM CORES, ');
  qryAdoCadKil.SQL.Add('   FORMULA_COR, ');
  qryAdoCadKil.SQL.Add('   ITEM ');
  qryAdoCadKil.SQL.Add(' WHERE CORES.COR = FORMULA_COR.COR ');
  qryAdoCadKil.SQL.Add('     AND CORES.ITEM = FORMULA_COR.ITEM ');
  qryAdoCadKil.SQL.Add('     AND CORES.ITEM = ITEM.CODIGO ');
  qryAdoCadKil.SQL.Add(' ORDER BY CORES.ITEM, CORES.COR, FORMULA_COR.OID_TIPO_ITEM ');
  qryAdoCadKil.Open;

  qryCadKil.SQL.Text := 'TRUNCATE TABLE KILD_CADKIL';
  qryCadKil.ExecSQL;
  qryCadKil.SQL.Clear;

  qryCadKil.SQL.Add(' INSERT INTO KILD_CADKIL ');
  qryCadKil.SQL.Add('             (AUTOINCREM, ');
  qryCadKil.SQL.Add('              KIL_CODCOR, ');
  qryCadKil.SQL.Add('              KIL_DESCRI, ');
  qryCadKil.SQL.Add('              KIL_REFERE, ');
  qryCadKil.SQL.Add('              KIL_CODBAS, ');
  qryCadKil.SQL.Add('              KIL_CODUNI, ');

  For intForm := 1 To 20 Do
  Begin
    qryCadKil.SQL.Add('              KIL_FORM' + fStrZero(intForm, 2) + ', ');
    qryCadKil.SQL.Add('              KIL_QTDB' + fStrZero(intForm, 2) + ', ');
  End;

  qryCadKil.SQL.Add('              KIL_CODFML) ');
  qryCadKil.SQL.Add(' VALUES (:AUTOINCREM, ');
  qryCadKil.SQL.Add('         :KIL_CODCOR, ');
  qryCadKil.SQL.Add('         :KIL_DESCRI, ');
  qryCadKil.SQL.Add('         :KIL_REFERE, ');
  qryCadKil.SQL.Add('         :KIL_CODBAS, ');
  qryCadKil.SQL.Add('         :KIL_CODUNI, ');

  For intForm := 1 To 20 Do
  Begin
    qryCadKil.SQL.Add('         :KIL_FORM' + fStrZero(intForm, 2) + ', ');
    qryCadKil.SQL.Add('         :KIL_QTDB' + fStrZero(intForm, 2) + ', ');
  End;

  qryCadKil.SQL.Add('         :KIL_CODFML); ');

  qryAdoCadBas := fCriaAdoQuery();
  qryAdoCadBas.SQL.Add(' SELECT ');
  qryAdoCadBas.SQL.Add('   BASES.ITEM, ');
  qryAdoCadBas.SQL.Add('   BASES.BASE, ');
  qryAdoCadBas.SQL.Add('   BASES.ITEM_BASE, ');
  qryAdoCadBas.SQL.Add('   CONTAINER.CONTAINER, ');
  qryAdoCadBas.SQL.Add('   CONTAINER.FATOR_CONVERCAO ');
  qryAdoCadBas.SQL.Add(' FROM BASES, ');
  qryAdoCadBas.SQL.Add('   CONTAINER ');
  qryAdoCadBas.SQL.Add(' WHERE BASES.ITEM = CONTAINER.ITEM ');
  qryAdoCadBas.SQL.Add(' ORDER BY BASES.ITEM, BASES.BASE ');
  qryAdoCadBas.Open;

  pRegistraAcao('Processando cadastro de cores...');
  While Not qryAdoCadKil.Eof Do
  Begin
    blnProximo := True;
      
    If qryAdoCadKil.FieldByName('OID_TIPO_ITEM').AsString = '1' Then
    Begin
      qryAdoCadBas.Filtered := False;
      qryAdoCadBas.Filter := 'ITEM = ' +
        QuotedStr(qryAdoCadKil.FieldByName('ITEM').AsString) +
        ' AND BASE = ' + QuotedStr(qryAdoCadKil.FieldByName('CD_MATERIAL').AsString);
      qryAdoCadBas.Filtered := True;

      If qryAdoCadBas.RecordCount = 0 Then
      Begin
//        Break;
        blnProximo := False;
        qryAdoCadKil.Next;
      End;
    End;

    intPosRecNo := qryAdoCadKil.RecNo;

    If blnProximo Then
    Begin
      qryCadKil.ParamByName('KIL_CODCOR').AsString := qryAdoCadKil.FieldByName('COR').AsString;
      qryCadKil.ParamByName('KIL_DESCRI').AsString := qryAdoCadKil.FieldByName('DESCRICAO').AsString;
      qryCadKil.ParamByName('KIL_REFERE').AsString := qryAdoCadKil.FieldByName('ITEM').AsString;
      qryCadKil.ParamByName('KIL_CODBAS').AsString := qryAdoCadKil.FieldByName('CD_MATERIAL').AsString;
      qryAdoCadKil.Next;

      qryAdoCadBas.First;
      While Not qryAdoCadBas.Eof Do
      Begin
        Limpar;

        If qryAdoCadKil.FieldByName('OID_TIPO_ITEM').AsString = '1' Then
          qryAdoCadKil.Next;

        qryCadKil.ParamByName('KIL_CODFML').AsString := qryAdoCadBas.FieldByName('ITEM_BASE').AsString;
        qryCadKil.ParamByName('KIL_CODUNI').AsString := qryAdoCadBas.FieldByName('CONTAINER').AsString;

        For intForm := 1 To 20 Do
        Begin
          qryCadKil.ParamByName('KIL_FORM' + fStrZero(intForm, 2)).AsString :=
            qryAdoCadKil.FieldByName('CD_MATERIAL').AsString;

          qryCadKil.ParamByName('KIL_QTDB' + fStrZero(intForm, 2)).AsFloat :=
            qryAdoCadKil.FieldByName('QTD_ONCAS').AsFloat * qryAdoCadBas.FieldByName('FATOR_CONVERCAO').AsFloat / 3.24;

          strCodCor := qryAdoCadKil.FieldByName('COR').AsString;
          qryAdoCadKil.Next;

          If (strCodCor <> qryAdoCadKil.FieldByName('COR').AsString) Or
             (qryAdoCadKil.RecNo = qryAdoCadKil.RecordCount) Then
          Begin
            qryCadKil.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('KILD_CADKIL', VS_strCodEmp);
            qryCadKil.ExecSQL;

            qryAdoCadBas.Next;

            If Not qryAdoCadBas.Eof Then
              qryAdoCadKil.RecNo := intPosRecNo;

            Break;
          End;
        End;

        pRegistraProgresso(0, qryAdoCadKil.RecNo, qryAdoCadKil.RecordCount);
      End;
    End;  
  End;
  pRegistraAcao('Cadastro de cores processado com sucesso!');

  Result := True;
end;

class procedure TKillingDinamica.pDeletaNovaFormulaDinamica(strCodPro: String);
Var
  qryDel: TUniQuery;
begin
  Try
    qryDel := fCriaQuery;

    qryDel.SQL.Clear;
    qryDel.Close;
    qryDel.SQL.Text := 'DELETE FROM KILD_CADKIL '+
                       ' WHERE KIL_CODNFM = :CODPRO ';

    qryDel.ParamByName('CODPRO').AsString := strCodPro;
    qryDel.ExecSQL;
  Finally
    FreeAndNil(qryDel);
  End;
end;

{ TKillingDinamicaFireBird }

constructor TKillingDinamicaFireBird.Create(AOwner: TComponent);
begin
  inherited;
  NomeTinta := 'Killing';
  conf      := fGetConfTinta('KIL');
  Provider  := TInterbaseUniProvider.Create(Nil);
end;

function TKillingDinamicaFireBird.fConnectionFdb: TUniConnection;
Var
  Con : TUniConnection;
begin
  Con := TUniConnection.Create(nil);

  Try
    Con.Database     := conf.fGet('PATKIL');
    Con.Username     := conf.fGet('USUKIL');
    Con.Password     := conf.fGet('SENKIL');
    Con.Server       := conf.fGet('SERKIL');
    Con.Port         := conf.fGetInteger('PORKIL');
    Con.ProviderName := 'Interbase';
    Con.Connect;

    Result := Con;
  Except
    On e : Exception Do
    Begin
      Result := Nil;
      fMensagem('ATENÇÃO!', 'Erro ao tentar conexão com o banco de dados!' + #13 +
        e.Message , ['&OK']);
    End;
  End
end;

function TKillingDinamicaFireBird.fGravarNovasFormulas: Boolean;
begin
  Result := True;
end;

function TKillingDinamicaFireBird.fProcessarArquivos: Boolean;
begin
  Result := fProcessarCadCol And fProcessarCadBas
    And fProcessarCadKil;
end;

function TKillingDinamicaFireBird.fProcessarCadBas: Boolean;
  Var
    qryBases  : TUniQuery;
    qryCadBas : TUniQuery;
    qryAux    : TUniQuery;
begin
  Result := False;
  Try
    Try
      qryBases := fCriaQuery(Nil, fConnectionFdb);

      qryBases.Close;
      qryBases.SQL.Clear;
      qryBases.SQL.Add(' SELECT ');
      qryBases.SQL.Add('   BASES.CODINTERNO, ');
      qryBases.SQL.Add('   BASES.NOME, ');
      qryBases.SQL.Add('   BASES.NOMELONGO, ');
      qryBases.SQL.Add('   EMBALAGENS.NOME AS CODUNI, ');
      qryBases.SQL.Add('   EMBALAGENS.ML ');
      qryBases.SQL.Add(' FROM ');
      qryBases.SQL.Add('   BASES, ');
      qryBases.SQL.Add('   EMBALAGENS ');
      qryBases.SQL.Add(' WHERE ');
      qryBases.SQL.Add('   BASES.CODEMB = EMBALAGENS.CODIGO ');
      qryBases.Open;

      qryCadBas := fCriaQuery;
      qryCadBas.Close;
      qryCadBas.SQL.Clear;
      qryCadBas.SQL.Add(' INSERT INTO KILD_CADBAS  ');
      qryCadBas.SQL.Add('             (BAS_CODFML, ');
      qryCadBas.SQL.Add('              BAS_CODBAS, ');
      qryCadBas.SQL.Add('              BAS_CODUNI, ');
      qryCadBas.SQL.Add('              BAS_EMBALA, ');
      qryCadBas.SQL.Add('              BAS_DESCRI, ');
      qryCadBas.SQL.Add('              BAS_CODEMP, ');
      qryCadBas.SQL.Add('              AUTOINCREM) ');
      qryCadBas.SQL.Add(' VALUES (:BAS_CODFML,  ');
      qryCadBas.SQL.Add('         :BAS_CODBAS,  ');
      qryCadBas.SQL.Add('         :BAS_CODUNI,  ');
      qryCadBas.SQL.Add('         :BAS_EMBALA,  ');
      qryCadBas.SQL.Add('         :BAS_DESCRI,  ');
      qryCadBas.SQL.Add('         :BAS_CODEMP,  ');
      qryCadBas.SQL.Add('         :AUTOINCREM); ');

      pRegistraAcao('Processando cadastro de bases...');

      qryBases.First;

      qryAux := fCriaQuery();

      While Not qryBases.Eof Do
      Begin
        qryAux.Close;
        qryAux.SQL.Text := ' SELECT * '+
                           '   FROM KILD_CADBAS '+
                           '  WHERE BAS_CODFML = :CODFML '+
                           '    AND BAS_CODUNI = :CODUNI '+
                           '    AND BAS_CODBAS = :CODBAS ';
        qryAux.ParamByName('CODFML').AsString := qryBases.FieldByName('CODINTERNO').AsString;
        qryAux.ParamByName('CODUNI').AsString := qryBases.FieldByName('CODUNI').AsString;
        qryAux.ParamByName('CODBAS').AsString := qryBases.FieldByName('NOME').AsString;
        qryAux.Open;

        If qryAux.isEmpty Then
        begin
          qryCadBas.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('KILD_CADBAS',  VS_strCodEmp);
          qryCadBas.ParamByName('BAS_CODFML').AsString := qryBases.FieldByName('CODINTERNO').AsString;
          qryCadBas.ParamByName('BAS_CODBAS').AsString := qryBases.FieldByName('NOME').AsString;
          qryCadBas.ParamByName('BAS_CODUNI').AsString := qryBases.FieldByName('CODUNI').AsString;
          qryCadBas.ParamByName('BAS_DESCRI').AsString := qryBases.FieldByName('NOMELONGO').AsString;
          qryCadBas.ParamByName('BAS_EMBALA').AsFloat  := qryBases.FieldByName('ML').AsFloat;
          qryCadBas.ParamByName('BAS_CODEMP').AsString := VS_strCodEmp;

          Try
            qryCadBas.ExecSQL;
          Except
            On E:EUniError Do
            Begin
              If E.ErrorCode = 1062 Then //DUPLICADO
                pRegistraAcao(Format('A base %s - %s - %s - %s já está cadastrado',
                [qryBases.FieldByName('CODINTERNO').AsString,
                 qryBases.FieldByName('NOME').AsString,
                 qryBases.FieldByName('CODUNI').AsString,
                 qryBases.FieldByName('NOMELONGO').AsString]))
              Else
                Raise;
            End;
          End;
        End;

        qryBases.Next;
        pRegistraProgresso(0, qryBases.RecNo, qryBases.RecordCount);
      End;

      pRegistraAcao('Cadastro de bases processado com sucesso!');

      Result := True;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryBases);
    FreeAndNil(qryCadBas);
  End;
end;

function TKillingDinamicaFireBird.fProcessarCadCol: Boolean;
  Var
    qryColorantes: TUniQuery;
    qryCadCol: TUniQuery;
begin
  Result := False;
  Try
    Try
      qryColorantes := fCriaQuery(Nil, fConnectionFdb);

      qryColorantes.Close;
      qryColorantes.SQL.Clear;
      qryColorantes.SQL.Add(' SELECT          ');
      qryColorantes.SQL.Add('     CODCORANTE, ');
      qryColorantes.SQL.Add('     NOMECORANTE ');
      qryColorantes.SQL.Add('   FROM CORANTES ');
      qryColorantes.SQL.Add('  WHERE CODCORANTE <> ''N/A'' ');
      qryColorantes.Open;

      qryCadCol := fCriaQuery;
      qryCadCol.Close;
      qryCadCol.SQL.Clear;
      qryCadCol.SQL.Add(' INSERT INTO KILD_CADCOL  ');
      qryCadCol.SQL.Add('             (AUTOINCREM, ');
      qryCadCol.SQL.Add('              COL_CODCOL, ');
      qryCadCol.SQL.Add('              COL_CODEMP, ');
      qryCadCol.SQL.Add('              COL_DESCRI) ');
      qryCadCol.SQL.Add(' VALUES (:AUTOINCREM,  ');
      qryCadCol.SQL.Add('         :COL_CODCOL,  ');
      qryCadCol.SQL.Add('         :COL_CODEMP,  ');
      qryCadCol.SQL.Add('         :COL_DESCRI); ');

      pRegistraAcao('Processando cadastro de colorantes...');

      qryColorantes.First;
      While Not qryColorantes.Eof Do
      Begin
        qryCadCol.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('KILD_CADCOL', VS_strCodEmp);
        qryCadCol.ParamByName('COL_CODCOL').AsString := qryColorantes.FieldByName('CODCORANTE').AsString;
        qryCadCol.ParamByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryCadCol.ParamByName('COL_DESCRI').AsString := qryColorantes.FieldByName('NOMECORANTE').AsString;

        Try
          qryCadCol.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode = 1062 Then //DUPLICADO
              pRegistraAcao(Format('O Colorante %s - %s já está cadastrado',
              [qryColorantes.FieldByName('CODCORANTE').AsString, qryColorantes.FieldByName('NOMECORANTE').AsString]))
            Else
              Raise;
          End;
        End;

        qryColorantes.Next;
        pRegistraProgresso(0, qryColorantes.RecNo, qryColorantes.RecordCount);
      End;

      pRegistraAcao('Cadastro de colorantes processado com sucesso!');

      Result := True;
    Except
      Raise;
    End;
  Finally
    FreeAndNil(qryColorantes);
    FreeAndNil(qryCadCol);
  End;
end;

function TKillingDinamicaFireBird.fProcessarCadKil: Boolean;
  Var
    qryKilling    : TUniQuery;
    qryCadBas     : TUniQuery;
    qryCadKil     : TUniQuery;
    qryCadCol     : TUniQuery;
    intForm       : Integer;
    strRegAnterior: String;
  procedure Limpar;
    Var
      i: Integer;
  Begin
    For i := 1 To 15 Do
    Begin
      qryCadKil.ParamByName('KIL_FORM' + fStrZero(i, 2)).Value := Null;
      qryCadKil.ParamByName('KIL_QTDB' + fStrZero(i, 2)).Value := Null;
    End;
  End;

  function fRetColorante(strCodigo: String): String;
  begin
    Result := strCodigo;
    If qryCadCol.Locate('CODIGO', strCodigo, []) Then
      Result := qryCadCol.FieldByName('CODCORANTE').AsString;
  end;
begin
  Result := False;
  Try
    Try
      qryKilling := fCriaQuery(Nil, fConnectionFdb);
      qryCadKil  := fCriaQuery;
      qryCadBas  := fCriaQuery(Nil, fConnectionFdb);
      qryCadCol  := fCriaQuery(Nil, fConnectionFdb);

      //Seleciona a formulacao
      qryKilling.SQL.Add(' SELECT PRODUTOS.NOME,                         ');
      qryKilling.SQL.Add('        PRODUTOS.NOMECURTO,                    ');
      qryKilling.SQL.Add('        FORMULAS.CODCOR,                       ');
      qryKilling.SQL.Add('        FORMULAS.NOMECOR,                      ');
      qryKilling.SQL.Add('        BASES.NOME AS BASE,                    ');
      qryKilling.SQL.Add('        BASES.CODINTERNO,                      ');
      qryKilling.SQL.Add('        FORMULAS.COR1,                         '); //fazer join com corantes
      qryKilling.SQL.Add('        FORMULAS.COR2,                         ');
      qryKilling.SQL.Add('        FORMULAS.COR3,                         ');
      qryKilling.SQL.Add('        FORMULAS.COR4,                         ');
      qryKilling.SQL.Add('        FORMULAS.COR5,                         ');
      qryKilling.SQL.Add('        FORMULAS.COR6,                         ');
      qryKilling.SQL.Add('        FORMULAS.COR7,                         ');
      qryKilling.SQL.Add('        FORMULAS.COR8,                         ');
      qryKilling.SQL.Add('        FORMULAS.SHOT1,                        ');
      qryKilling.SQL.Add('        FORMULAS.SHOT2,                        ');
      qryKilling.SQL.Add('        FORMULAS.SHOT3,                        ');
      qryKilling.SQL.Add('        FORMULAS.SHOT4,                        ');
      qryKilling.SQL.Add('        FORMULAS.SHOT5,                        ');
      qryKilling.SQL.Add('        FORMULAS.SHOT6,                        ');
      qryKilling.SQL.Add('        FORMULAS.SHOT7,                        ');
      qryKilling.SQL.Add('        FORMULAS.SHOT8                         ');
      qryKilling.SQL.Add('   FROM FORMULAS,                              ');
      qryKilling.SQL.Add('        PRODUTOS,                              ');
      qryKilling.SQL.Add('        BASES                                  ');
      qryKilling.SQL.Add('  WHERE FORMULAS.CODPRODUTO = PRODUTOS.CODIGO  ');
      qryKilling.SQL.Add('    AND FORMULAS.CODBASE = BASES.CODIGO        ');
      qryKilling.SQL.Add('  ORDER BY PRODUTOS.NOMECURTO, FORMULAS.CODCOR ');
      qryKilling.Open;

      qryCadKil.SQL.Text := 'TRUNCATE TABLE KILD_CADKIL';
      qryCadKil.ExecSQL;
      qryCadKil.SQL.Clear;

      // Seleciona os campo para insert no banco
      qryCadKil.SQL.Add(' INSERT INTO KILD_CADKIL  ');
      qryCadKil.SQL.Add('             (AUTOINCREM, ');
      qryCadKil.SQL.Add('              KIL_CODCOR, ');
      qryCadKil.SQL.Add('              KIL_NOMCOR, ');
      qryCadKil.SQL.Add('              KIL_DESCRI, ');
      qryCadKil.SQL.Add('              KIL_REFERE, ');
      qryCadKil.SQL.Add('              KIL_CODBAS, ');
      qryCadKil.SQL.Add('              KIL_CODUNI, ');

      For intForm := 1 To 15 Do
      Begin
        qryCadKil.SQL.Add('              KIL_FORM' + fStrZero(intForm, 2) + ', ');
        qryCadKil.SQL.Add('              KIL_QTDB' + fStrZero(intForm, 2) + ', ');
      End;

      qryCadKil.SQL.Add('              KIL_CODFML) ');
      qryCadKil.SQL.Add(' VALUES (:AUTOINCREM, ');
      qryCadKil.SQL.Add('         :KIL_CODCOR, ');
      qryCadKil.SQL.Add('         :KIL_NOMCOR, ');
      qryCadKil.SQL.Add('         :KIL_DESCRI, ');
      qryCadKil.SQL.Add('         :KIL_REFERE, ');
      qryCadKil.SQL.Add('         :KIL_CODBAS, ');
      qryCadKil.SQL.Add('         :KIL_CODUNI, ');

      For intForm := 1 To 15 Do
      Begin
        qryCadKil.SQL.Add('         :KIL_FORM' + fStrZero(intForm, 2) + ', ');
        qryCadKil.SQL.Add('         :KIL_QTDB' + fStrZero(intForm, 2) + ', ');
      End;

      qryCadKil.SQL.Add('         :KIL_CODFML); ');


      //Seleciona as bases
      qryCadBas.SQL.Text := 'SELECT '+
                            '   TABELA.CONC, '+
                            '   PRODUTOS.NOMECURTO, '+
                            '   BASES.CODINTERNO, '+
                            '   BASES.NOME, '+
                            '   BASES.NOMELONGO, '+
                            '   EMBALAGENS.NOME AS CODUNI, '+
                            '   EMBALAGENS.ML '+
                            ' FROM '+
                            '   BASES, '+
                            '   EMBALAGENS, '+
                            '   PRODUTOS, '+
                            '   (SELECT (BASES.CODINTERNO||EMBALAGENS.NOME||BASES.NOME)CONC '+
                            '      FROM BASES, '+
                            '           EMBALAGENS, '+
                            '           PRODUTOS '+
                            '     WHERE BASES.CODEMB  = EMBALAGENS.CODIGO '+
                            '       AND BASES.CODPROD = PRODUTOS.CODIGO) TABELA '+
                            ' WHERE BASES.CODEMB  = EMBALAGENS.CODIGO '+
                            '   AND BASES.CODPROD = PRODUTOS.CODIGO '+
                            '   AND TABELA.CONC = (BASES.CODINTERNO||EMBALAGENS.NOME||BASES.NOME) '+
                            ' ORDER BY TABELA.CONC ';

      qryCadBas.Open;

      //Seleciona os colorantes
      qryCadCol.SQL.Add(' SELECT       ');
      qryCadCol.SQL.Add('   CODIGO,    ');
      qryCadCol.SQL.Add('   CODCORANTE ');
      qryCadCol.SQL.Add(' FROM ');
      qryCadCol.SQL.Add('   CORANTES ');
      qryCadCol.SQL.Add(' WHERE ');
      qryCadCol.SQL.Add('   CODCORANTE <> ''N/A'' ');
      qryCadCol.Open;

      pRegistraAcao('Processando cadastro de cores...');

      qryKilling.First;

      strRegAnterior := '';

      While Not qryKilling.Eof Do
      Begin
        qryCadBas.Filtered := False;
        qryCadBas.Filter := 'CODINTERNO = ' + QuotedStr(qryKilling.FieldByName('CODINTERNO').AsString) +
                            '  AND NOME = ' + QuotedStr(qryKilling.FieldByName('BASE').AsString);

        qryCadBas.Filtered := True;

        If qryCadBas.RecordCount = 0 Then
        Begin
          qryKilling.Next;
          pRegistraProgresso(0, qryKilling.RecNo, qryKilling.RecordCount);
          Continue;
        End;

        qryCadKil.ParamByName('KIL_CODCOR').AsString := qryKilling.FieldByName('CODCOR').AsString;
        qryCadKil.ParamByName('KIL_NOMCOR').AsString := qryKilling.FieldByName('NOMECOR').AsString;
        qryCadKil.ParamByName('KIL_DESCRI').AsString := qryKilling.FieldByName('NOME').AsString;
        qryCadKil.ParamByName('KIL_REFERE').AsString := qryKilling.FieldByName('NOMECURTO').AsString;
        qryCadKil.ParamByName('KIL_CODBAS').AsString := qryKilling.FieldByName('BASE').AsString;

        qryCadBas.First;

        While Not qryCadBas.Eof Do
        Begin
          Limpar;

          If (strRegAnterior <> qryCadBas.FieldbyName('CONC').AsString) Then
          Begin
            strRegAnterior := qryCadBas.FieldbyName('CONC').AsString;

            qryCadKil.ParamByName('KIL_CODFML').AsString := qryCadBas.FieldByName('CODINTERNO').AsString;
            qryCadKil.ParamByName('KIL_CODUNI').AsString := qryCadBas.FieldByName('CODUNI').AsString;

            For intForm := 1 To 15 Do
            Begin
              If qryKilling.FindField('COR' + IntToStr(intForm)) = Nil Then
                Break;

              If qryKilling.FieldByName('COR' + IntToStr(intForm)).AsString = '0' Then
                Break;

              qryCadKil.ParamByName('KIL_FORM' + fStrZero(intForm, 2)).AsString :=
                fRetColorante(qryKilling.FieldByName('COR' + IntToStr(intForm)).AsString);

              qryCadKil.ParamByName('KIL_QTDB' + fStrZero(intForm, 2)).AsFloat :=
                qryKilling.FieldByName('SHOT' + IntToStr(intForm)).AsFloat * qryCadBas.FieldByName('ML').AsFloat / 3240;
            End;

            qryCadKil.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('KILD_CADKIL', VS_strCodEmp);
            qryCadKil.ExecSQL;

          End;

          qryCadBas.Next;

        End;

        qryKilling.Next;
        pRegistraProgresso(0, qryKilling.RecNo, qryKilling.RecordCount);
      End;

      pRegistraAcao('Cadastro de cores processado com sucesso!');

      Result := True;
    Except
      On E: Exception Do
      Begin
        fMensagem('Atenção', E.Message, ['%Ok']);
      End;
    End;
  Finally
    FreeAndNil(qryKilling);
    FreeAndNil(qryCadKil);
    FreeAndNil(qryCadBas);
    FreeAndNil(qryCadCol);
    FreeAndNil(Provider);
  End;
end;

end.
