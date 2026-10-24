unit untBrasimixAutomotivaDinamica;

interface
  uses SysUtils, Uni, ExtCtrls, Classes, Dialogs, Forms,
       StrUtils;

  Type
    TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
    TEventoStrAcao = procedure(strAcao: String) of object;

    TBrasimixAutomotivaDinamica = class(TComponent)
    private
      FRegistraAcao: TEventoStrAcao;
      FRegistraProgresso: TEventoProgresso;
    protected

    public
      function fGravarNovasFormulas: Boolean;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
    published
      property RegistraAcao: TEventoStrAcao read FRegistraAcao write FRegistraAcao;
      property RegistraProgresso: TEventoProgresso read FRegistraProgresso write FRegistraProgresso;
    end;


    TFormBases = Record
      strCodBas : String;
      fltQtdBas : Double;
  End;

  function fImportarArquivoBrasimix(var pnlSaida: TPanel; var stlTintasNaoGeradas: TStringList;
    var stlBasesNaoCad: TStringList; blnGerBas: Boolean): Boolean;
  function fProcessaLinhaBrasimix(strLinha: String; var stlBasesNaoCad: TStringList;
            var stlTintasNaoGeradas: TStringList; var qryCadBza: TUniQuery; var qryCadBas: TUniQuery; intAutincrem: Integer;
            blnGerBas: Boolean): Boolean;
  function fGravaCadBza(strAutoi: String; strCodigo: String; strMontad: String; strAno: String;
            strDescri: String; strCodUni: String; strTipo: String; arrBases: array of TFormBases;
            qryCadBza: TUniQuery): Boolean;
  function fProcessaTipo(strTipo: String): String;
  function fVerificaCadBas: Boolean;
  function fLinhasArquivo(strArquivo: String): Integer;
  function fGravaNovaFormula(qryNfm : TUniQuery): Boolean;
  function fRetUltCodSeq(strNomeTabela: String; strNomeCampo: String): Integer;
  function fApagaCadBzaNfm(CodNfm: String): Boolean;
  function fGravarNovasFormulas: Boolean;
  function fValidaTipos(strTipo: String): Boolean;
  function fGravaCadBas(arrBases: array of TFormBases; qryCadBas: TUniQuery): Boolean;

implementation

uses  untFuncoes, DB, untFuncoesSimples, untTintadeMaquina,
      untIConfTinta, untFuncTinta;

function fImportarArquivoBrasimix(var pnlSaida: TPanel;
  var stlTintasNaoGeradas: TStringList; var stlBasesNaoCad: TStringList;
  blnGerBas: Boolean): Boolean;
  Var
    arqBzaTxt : TextFile;
    strLinha  : String;
    strArquivo: String;

    qryCadBza : TUniQuery;
    qryCadBas : TUniQuery;
    intLinhas : Integer;
    intCont   : Integer;
    conf: IConfTinta;
begin
  Result := False;
  conf   := fGetConfTinta('BZA');


  stlBasesNaoCad.Sorted := True;
  stlTintasNaoGeradas.Sorted := True;
  stlBasesNaoCad.Duplicates := dupIgnore;
  stlTintasNaoGeradas.Duplicates := dupIgnore;

  strArquivo := conf.fGet('PATBZA'); //fArqIniTinta(0, 'Brasimix Automotiva', 'PATBZA', '');

  If Not FileExists(strArquivo) Then
  begin
    fMensagem('', 'Não foi encontrado o TXT para geração.' + #13#10 +
                  'Caminho: ' + strArquivo, ['&Ok']);
    Exit;
  end;

  If (Not blnGerBas) Then
  Begin
    If Not fVerificaCadBas Then
    Begin
      fMensagem('', 'O Cadastro de bases está vazio!', ['&OK']);
      Exit;
    End;

    pZapTable('BZA_CADBZA');
  End;

  intLinhas := fLinhasArquivo(strArquivo);
  intCont := 1;

  AssignFile(arqBzaTxt, strArquivo);
  Reset(arqBzaTxt);

  qryCadBza := fCriaQuery;
  qryCadBza.SQL.Text := 'SELECT * FROM BZA_CADBZA';
  qryCadBza.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * FROM BZA_CADBAS';
  qryCadBas.Open;

  While (Not Eof(arqBzaTxt)) Do
  Begin
    Readln(arqBzaTxt, strLinha);
    If Not fProcessaLinhaBrasimix(strLinha, stlBasesNaoCad, stlTintasNaoGeradas, qryCadBza, qryCadBas, intCont, blnGerBas) Then
      Exit;
    pnlSaida.Caption := Format('Processando Arquivo (%d/%d)(%.2f%%)', [intCont, intLinhas, (100 * intCont / intLinhas)]);
    Inc(intCont);
    Application.ProcessMessages;
  End;

  If (Not blnGerBas) Then
  Begin
    If Not fGravarNovasFormulas Then
      Exit;
  End;

  CloseFile(arqBzaTxt);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadBza);
  Result := True;
end;

function fProcessaLinhaBrasimix(strLinha: String; var stlBasesNaoCad: TStringList;
            var stlTintasNaoGeradas: TStringList; var qryCadBza: TUniQuery;
            var qryCadBas: TUniQuery; intAutincrem: Integer;
            blnGerBas: Boolean): Boolean;
  Var
    strCodigo : String;
    strTipo   : String;
    strMontad : String;
    strAno    : String;
    strDescri : String;
    strCodUni : String;

    arrBases  : array of TFormBases;
    strBases  : String;
    strAutoi  : String;

    blnGravar:  Boolean;
begin
  Result := False;

  SetLength(arrBases, 0);

  strCodigo :=  Copy(strLinha, 001, 006);
  strTipo   :=  Copy(strLinha, 007, 002);
  strMontad :=  Trim(Copy(strLinha, 009, 050));
  strAno    :=  Copy(strLinha, 059, 004);
  strDescri :=  Trim(Copy(strLinha, 063, 050));
  strCodUni :=  Trim(copy(strLinha, 113, 050));
  strBases  :=  Copy(strLinha, 172, Length(strLinha));

  strTipo := fProcessaTipo(strTipo);
  strAutoi  := fFormataAutInc(intAutincrem, VS_strCodEmp);

  blnGravar := True;

  If (fArqIniTinta(0, 'USA_FORMUL', 'BZA', 'S') = 'S') Then
  Begin
    While (Not fEmptyStr(strBases)) Do
    Begin
      SetLength(arrBases, Length(arrBases) + 1);
      arrBases[Length(arrBases) - 1].strCodBas := Trim(Copy(strBases, 1, 7));

      If (Not blnGerBas) Then
      Begin
        If Not qryCadBas.Locate('BAS_CODBAS', arrBases[Length(arrBases) - 1].strCodBas, []) Then
        Begin
          stlBasesNaoCad.Add(arrBases[Length(arrBases) - 1].strCodBas);
          blnGravar := False;
          Break;
        End;
      End;

      strBases := Copy(strBases, 8, Length(strBases));
      arrBases[Length(arrBases) - 1].fltQtdBas := fStrToFloat(AnsiReplaceStr(Copy(strBases, 1, 9), '-', '')) / 100;
      strBases := Copy(strBases, 10, Length(strBases));
    End;
  End;

  If blnGravar Then
  Begin
    If blnGerBas Then
    Begin
      If Not fGravaCadBas(arrBases, qryCadBas) Then
      Begin
        Exit;
      End;
    End
    Else
    Begin
      If Not fGravaCadBza(strAutoi, strCodigo, strMontad, strAno, strDescri, strCodUni, strTipo, arrBases, qryCadBza) Then
      Begin
        Exit;
      End;
    End;
  End
  Else
    stlTintasNaoGeradas.Add(strCodigo + ' - ' + strDescri);

  Result := True;
end;

function fGravaCadBza(strAutoi: String; strCodigo: String; strMontad: String; strAno: String;
          strDescri: String; strCodUni: String; strTipo: String; arrBases: array of TFormBases;
          qryCadBza: TUniQuery): Boolean;
var
  intCont:  Integer;
  strMd5: string;
begin
  Result := True;
  Try
    Try
      qryCadBza.Insert;
      qryCadBza.FieldByName('AUTOINCREM').AsString := strAutoi;
      qryCadBza.FieldByName('BZA_CODEMP').AsString := VS_strCodEmp;
      qryCadBza.FieldByName('BZA_CODSEQ').AsString := strCodigo;
      qryCadBza.FieldByName('BZA_MONTAD').AsString := strMontad;
      qryCadBza.FieldByName('BZA_A_N_O_').AsString := strAno;
      qryCadBza.FieldByName('BZA_DESCRI').AsString := strDescri;
      qryCadBza.FieldByName('BZA_CODUNI').AsString := strCodUni;
      qryCadBza.FieldByName('BZA_ARQTXT').AsString := strTipo;

      If fGetConfTinta('BZA').fGetBoolean('USAFOR') Then
      For intCont := Low(arrBases) To High(arrBases) Do
      Begin
        qryCadBza.FieldByName('BZA_CODB' + fStrZero(intCont + 1, 2)).AsString := arrBases[intCont].strCodBas;
        qryCadBza.FieldByName('BZA_QTDB' + fStrZero(intCont + 1, 2)).AsFloat  := arrBases[intCont].fltQtdBas;
      End;

      strMd5 := Trim(qryCadBza.FieldByName('BZA_MONTAD').AsString) +
        Trim(qryCadBza.FieldByName('BZA_A_N_O_').AsString) +
        Trim(qryCadBza.FieldByName('BZA_DESCRI').AsString) +
        Trim(qryCadBza.FieldByName('BZA_CODUNI').AsString) +
        Trim(qryCadBza.FieldByName('BZA_ARQTXT').AsString);

      for intCont := 1 to 15 do
      begin
        strMd5 := strMd5 + Trim(qryCadBza.FieldByName('BZA_CODB' + fStrZero(intCont, 2)).AsString) +
          StringReplace(FormatFloat('0.00000', qryCadBza.FieldByName('BZA_QTDB' + fStrZero(intCont, 2)).AsFloat), ',', '.', [rfReplaceAll]);
      end;

      qryCadBza.FieldByName('BZA_MD5KEY').AsString := GetMD5(strMd5);
      qryCadBza.Post;
    Except
      qryCadBza.Cancel;
    End;
  Finally

  End;

end;

function fProcessaTipo(strTipo: String): String;
begin
  If (strTipo = 'PE') Then
    Result := 'POLIESTER'
  Else If (strTipo = 'PU') Then
    Result := 'POLIURETANO FLEET 3X1'
  Else If (strTipo = 'PH') Then
    Result := 'POLIURETANO H.S. 2X1'
  Else If (strTipo = 'SR') Then
    Result := 'SINT. EXTRA-RAPIDO'
  Else If (strTipo = 'ST') Then
    Result := 'SINT. AUTOMOTIVO'
  Else If (strTipo = 'SB') Then
    Result := 'SINT. RAPIDO BRASILIAR'
  Else If (strTipo = 'SI') Then
    Result := 'SINT. RODOAGROINDUSTRIAL'
  Else If (strTipo = 'LC') Then
    Result := 'LACA NITRO-CELULOSE'
  Else If (strTipo = 'LA') Then
    Result := 'LACA NITRO AUTOMOTIVA'
  Else If (strTipo = 'EP') Then
    Result := 'EPOXI'
  Else If (strTipo = 'PM') Then
    Result := 'POLIURETANO PREMIUM 4X1'
  Else If (strTipo = 'PP') Then
    Result := 'POLIESTER PREMIUM'
  Else If (strTipo = 'EM') Then
    Result := 'EPOXI POLIAMINA'
  Else If (strTipo = 'PR') Then
    Result := 'POLIURETANO PREM. HS 4X1'
  Else If (strTipo = 'PD') Then
    Result := 'POLIURETANO PARA MADEIRA'
  Else If (strTipo = 'ED') Then
    Result := 'EPOX POLIAMIDA PLUS'
end;

function fVerificaCadBas: Boolean;
  Var
    qryCadBas : TUniQuery;
begin
  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * FROM BZA_CADBAS';
  qryCadBas.Open;
  Result := Not qryCadBas.IsEmpty;

  FreeAndNil(qryCadBas);
end;

function fLinhasArquivo(strArquivo: String): Integer;
  Var
    arqTxt :  TextFile;
    intCont:  Integer;
begin
  AssignFile(arqTxt, strArquivo);
  Reset(arqTxt);
  intCont := 0;
  While Not Eof(arqTxt) Do
  Begin
    Readln(arqTxt);
    Inc(intCont);
  End;
  CloseFile(arqTxt);
  Result := intCont;
end;

function fGravaNovaFormula(qryNfm : TUniQuery): Boolean;
var
  qryCadBza : TUniQuery;
  intCont   : Integer;
  strMd5: string;
begin
  qryCadBza := fCriaQuery;
  qryCadBza.SQL.Text := 'DELETE FROM BZA_CADBZA WHERE BZA_CODNFM = :CODNFM';
  qryCadBza.ParamByName('CODNFM').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
  qryCadBza.ExecSQL;

  qryCadBza.Close;
  qryCadBza.SQL.Text := 'SELECT * FROM BZA_CADBZA WHERE FALSE';
  qryCadBza.Open;

  qryCadBza.Insert;
  qryCadBza.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('BZA_CADBZA', VS_strCodEmp);
  qryCadBza.FieldByName('BZA_CODEMP').AsString  := VS_strCodEmp;
  qryCadBza.FieldByName('BZA_CODSEQ').AsInteger := fRetUltCodSeq('BZA_CADBZA', 'BZA_CODSEQ');
  qryCadBza.FieldByName('BZA_MONTAD').AsString  := qryNfm.FieldByName('NFM_MONTAD').AsString;
  qryCadBza.FieldByName('BZA_A_N_O_').AsString  := qryNfm.FieldByName('NFM_A_N_O_').AsString;
  qryCadBza.FieldByName('BZA_DESCRI').AsString  := qryNfm.FieldByName('NFM_DESCRI').AsString;
  qryCadBza.FieldByName('BZA_ARQTXT').AsString  := fProcessaTipo(qryNfm.FieldByName('NFM_TIPO__').AsString);
  qryCadBza.FieldByName('BZA_CODUNI').AsString  := qryNfm.FieldByName('NFM_CODUNI').AsString;
  qryCadBza.FieldByName('BZA_ACRMOB').AsFloat   := qryNfm.FieldByName('NFM_ACRMOB').AsFloat;
  qryCadBza.FieldByName('BZA_DTACAD').AsDateTime   := qryNfm.FieldByName('NFM_DTACAD').AsDateTime;

  For intCont := 1 To 15 Do
  Begin
    If fEmptyStr(qryNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString) Then
      Break;

    qryCadBza.FieldByName('BZA_CODB' + fStrZero(intCont, 2)).AsString  := qryNfm.FieldByName('NFM_CODB' + fStrZero(intCont, 2)).AsString;
    qryCadBza.FieldByName('BZA_QTDB' + fStrZero(intCont, 2)).AsString  := qryNfm.FieldByName('NFM_QTDB' + fStrZero(intCont, 2)).AsString;
  End;

  qryCadBza.FieldByName('BZA_CODNFM').AsString  := qryNfm.FieldByName('NFM_CODNFM').AsString;

  strMd5 := qryCadBza.FieldByName('BZA_MONTAD').AsString +
    qryCadBza.FieldByName('BZA_A_N_O_').AsString +
    qryCadBza.FieldByName('BZA_DESCRI').AsString +
    qryCadBza.FieldByName('BZA_CODUNI').AsString +
    qryCadBza.FieldByName('BZA_ARQTXT').AsString;

  for intCont := 1 to 15 do
  begin
    strMd5 := strMd5 + qryCadBza.FieldByName('BZA_CODB' + fStrZero(intCont, 2)).AsString +
      StringReplace(FormatFloat('0.00000', qryCadBza.FieldByName('BZA_QTDB' + fStrZero(intCont, 2)).AsFloat), ',', '.', [rfReplaceAll]);
  end;

  qryCadBza.FieldByName('BZA_MD5KEY').AsString := GetMD5(strMd5);
  qryCadBza.Post;

  FreeAndNil(qryCadBza);
  Result := True;
end;

function fRetUltCodSeq(strNomeTabela: String; strNomeCampo: String): Integer;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := Format('SELECT MAX(CAST(%s AS UNSIGNED INT)) %s FROM %s ORDER BY %s', [strNomeCampo, strNomeCampo, strNomeTabela, strNomeCampo]);
  qryGen.Open;
  If fEmptyStr(qryGen.FieldByName(strNomeCampo).AsString) Then
    Result := 1
  Else
    Result := qryGen.FieldByName(strNomeCampo).AsInteger + 1;
  FreeAndNil(qryGen);
end;

function fApagaCadBzaNfm(CodNfm: String): Boolean;
  Var
    qryGen  : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'DELETE FROM BZA_CADBZA WHERE BZA_CODNFM = ' + QuotedStr(CodNfm);
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
  Result := True;
end;

function fGravarNovasFormulas: Boolean;
  Var
    qryCadNfm : TUniQuery;
    intCont   : Integer;
begin
  qryCadNfm := fCriaQuery;
  qryCadNfm.SQL.Text := 'SELECT * FROM BZA_CADNFM';
  qryCadNfm.Open;
  qryCadNfm.First;

  For intCont := 1 To qryCadNfm.RecordCount Do
  Begin
    If Not fGravaNovaFormula(qryCadNfm) Then
      Break;

    qryCadNfm.Next;
  End;
  FreeAndNil(qryCadNfm);
  Result := True;
end;

function fValidaTipos(strTipo: String): Boolean;
begin
  Result := True;
  If (strTipo <> 'PE') and (strTipo <> 'PU') and (strTipo <> 'LC') and (strTipo <> 'ST') and
     (strTipo <> 'EP') and (strTipo <> 'SB') and (strTipo <> 'PH') and (strTipo <> 'SI') and
     (strTipo <> 'SR') and (strTipo <> 'LA') and (strTipo <> 'PM') and (strTipo <> 'PP') Then

     Result := False;
end;

{ TBrasimixAutomotivaDinamica }

constructor TBrasimixAutomotivaDinamica.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TBrasimixAutomotivaDinamica.Destroy;
begin
  inherited;
end;
function TBrasimixAutomotivaDinamica.fGravarNovasFormulas: Boolean;
  Var
    qryCadNfm : TUniQuery;
    intCont   : Integer;
begin
  qryCadNfm := fCriaQuery;
  qryCadNfm.SQL.Text := 'SELECT * FROM BZA_CADNFM';
  qryCadNfm.Open;
  qryCadNfm.First;

  If Assigned(FRegistraAcao) Then FRegistraAcao('Cadastrando novas formulas...');
  TTintadeMaquina.fAjustaInicialAutoIncremento('BZA_CADBZA', VS_strCodEmp);
  For intCont := 1 To qryCadNfm.RecordCount Do
  Begin
    If Not fGravaNovaFormula(qryCadNfm) Then
      Break;

    qryCadNfm.Next;
    If Assigned(FRegistraProgresso) Then FRegistraProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
  End;

  FreeAndNil(qryCadNfm);
  If Assigned(FRegistraAcao) Then FRegistraAcao('Cadastro de novas formulas realizado com sucesso!');

  Result := True;
end;

function fGravaCadBas(arrBases: array of TFormBases; qryCadBas: TUniQuery): Boolean;
  Var
    intContador: Integer;
begin

  For intContador := Low(arrBases) To High(arrBases) Do
  Begin
    If Not qryCadBas.Locate('BAS_CODBAS', arrBases[intContador].strCodBas, []) Then
    Begin
      qryCadBas.Append;
      qryCadBas.FieldByName('BAS_CODBAS').AsString := arrBases[intContador].strCodBas;
      qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('BZA_CADBAS', VS_strCodEmp);
      qryCadBas.FieldByName('BAS_PESPEC').AsFloat  := 0;
      qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := 0;
      qryCadBas.Post;
    End;
  End;

  Result := True;

end;

end.

