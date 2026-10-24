unit untTProFaixasMetragem;

interface

uses Classes, SysUtils, StrUtils, Generics.Collections, Aurelius.Bind.Dataset,
  DB, System.Generics.Defaults, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Controls, untTypesSistema, Vcl.ExtCtrls, UniClientDataSet, Uni, EditFocus,
  Types, Vcl.Graphics, CRAccess, System.Variants, MemoFocus, Vcl.ComCtrls,
  untIZClient, System.DateUtils, System.Generics.Collections;

Type
  TCampoValidacao = (cvNone, cvFaiIni, cvFaiFin, cvIteFat, cvIniInterv, cvFinInterv, cvIntervalo);

  TFaixasMetragem = Class(TComponent)
  Private
    FCodIte: String;
    FAlterando: Boolean;
    FFaixas: TUniClientDataSet;

    Const
      SQL_SELECT = 'SELECT * FROM ITEFAI WHERE ITE_CODITE = :CODITE';
      SQL_SELECT_FATOR = 'SELECT ITE_ITEFAT FROM ITEFAI WHERE ITE_CODITE = :CODITE AND ITE_FAIINI <= :QTDITE AND ITE_FAIFIN >= :QTDITE';
      SQL_INSERT = 'INSERT INTO ITEFAI (' +
                      ' AUTOINCREM, ' +
                      ' ITE_CODITE, ' +
                      ' ITE_FAIINI, ' +
                      ' ITE_FAIFIN, ' +
                      ' ITE_ITEFAT) VALUES (  ' +
                      ' :AUTINC, ' +
                      ' :CODITE, ' +
                      ' :FAIINI, ' +
                      ' :FAIFIN, ' +
                      ' :ITEFAT) ';

      SQL_UPDATE = 'UPDATE ITEFAI SET ' +
                      '   ITE_FAIINI = :FAIINI, ' +
                      '   ITE_FAIFIN = :FAIFIN, ' +
                      '   ITE_ITEFAT = :ITEFAT  ' +
                      ' WHERE AUTOINCREM = :AUTINC';
      SQL_DELETE = 'DELETE FROM ITEFAI WHERE AUTOINCREM = :AUTINC';
      SQL_DELETE_PROD = 'DELETE FROM ITEFAI WHERE ITE_CODITE = :CODITE';

    procedure pCriarClientDataSet;
    procedure pSetFiltro;
    procedure pCarregarFaixasItem;
  Public
    Constructor Create(AOwner: TComponent); Reintroduce; Overload;
    Destructor Destroy; Override;

    function  fInserirFaixa(fltFaiIni, fltFaiFin, fltIteFat: Double): Boolean;
    function  fAlterarFaixa(fltFaiIni, fltFaiFin, fltIteFat: Double): Boolean;
    function  fRemoverFaixa: Boolean;
    function  fSalvar: Boolean;
    function  fCarregarFaixasItem: TUniClientDataSet;
    function  fValidarFaixa(fltFaiIni, fltFaiFin, fltIteFat: Double): TCampoValidacao;

    class procedure pExcluirFaixas(strCodItem: String);
    class function  fRetFatorFaixaMetragem(strCodItem: String; fltQtdIte: Double): Double;

    property strCodIte: String            Read FCodIte Write FCodIte;
    property cdsFaixas: TUniClientDataSet Read FFaixas Write FFaixas;
    property blnAlterando: Boolean        Read FAlterando Write FAlterando;
  End;

implementation

{ TFaixaMetragem }

constructor TFaixasMetragem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FFaixas := TUniClientDataSet.Create(AOwner);
  FCodIte := '';
  FAlterando := False;

  pCriarClientDataSet();
  pSetFiltro();
end;

destructor TFaixasMetragem.Destroy;
begin
  FreeAndNil(FFaixas);

  inherited;
end;

function TFaixasMetragem.fAlterarFaixa(fltFaiIni, fltFaiFin,
  fltIteFat: Double): Boolean;
begin
  Result := False;

  Try
    FFaixas.DisableControls();

    Try
      FFaixas.Edit();

      FFaixas.FieldByName('ITE_FAIINI').AsFloat  := fltFaiIni;
      FFaixas.FieldByName('ITE_FAIFIN').AsFloat  := fltFaiFin;
      FFaixas.FieldByName('ITE_ITEFAT').AsFloat  := fltIteFat;

      If (Not fEmptyStr(FFaixas.FieldByName('AUTOINCREM').AsString)) Then
        FFaixas.FieldByName('OPERAC').AsString := 'A';

      FFaixas.Post();

      Result := True;
    Except
      On E : Exception Do
        pMensagensErro(E.Message, '[TFaixasMetragem.fInserirFaixa]');
    End;
  Finally
    pSetFiltro();
    FFaixas.EnableControls();
  End;
end;

function TFaixasMetragem.fCarregarFaixasItem: TUniClientDataSet;
begin
  pCarregarFaixasItem();
  Result := FFaixas;
end;

function TFaixasMetragem.fInserirFaixa(fltFaiIni, fltFaiFin,
  fltIteFat: Double): Boolean;
begin
  Result := False;

  Try
    FFaixas.DisableControls();

    Try
      FFaixas.Append();

      FFaixas.FieldByName('AUTOINCREM').AsString := '';
      FFaixas.FieldByName('ITE_FAIINI').AsFloat  := fltFaiIni;
      FFaixas.FieldByName('ITE_FAIFIN').AsFloat  := fltFaiFin;
      FFaixas.FieldByName('ITE_ITEFAT').AsFloat  := fltIteFat;
      FFaixas.FieldByName('OPERAC').AsString     := 'I';
      FFaixas.FieldByName('ID').AsInteger        := FFaixas.RecordCount + 1;

      FFaixas.Post();

      Result := True;
    Except
      On E : Exception Do
        pMensagensErro(E.Message, '[TFaixasMetragem.fInserirFaixa]');
    End;
  Finally
    pSetFiltro();
    FFaixas.EnableControls();
  End;
end;

function TFaixasMetragem.fRemoverFaixa: Boolean;
begin
  Result := False;

  Try
    FFaixas.DisableControls();

    Try
      FFaixas.Edit();
      FFaixas.FieldByName('OPERAC').AsString := 'E';
      FFaixas.Post();

      Result := True;
    Except
      On E : Exception Do
        pMensagensErro(E.Message, '[TFaixasMetragem.fRemoverFaixa]');
    End;
  Finally
    pSetFiltro();
    FFaixas.EnableControls();
  End;
end;

class function TFaixasMetragem.fRetFatorFaixaMetragem(strCodItem: String; fltQtdIte: Double): Double;
  Var
    qryTemp: TUniQuery;
begin
  Result := 1;

  Try
    qryTemp := fCriaQuery();

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := SQL_SELECT_FATOR;
      qryTemp.ParamByName('CODITE').AsString := strCodItem;
      qryTemp.ParamByName('QTDITE').AsFloat  := fltQtdIte;
      qryTemp.Open();

      If (Not qryTemp.IsEmpty) Then
        Result := qryTemp.FieldByName('ITE_ITEFAT').AsFloat;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TFaixasMetragem.fRetFatorFaixaMetragem]');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TFaixasMetragem.fSalvar: Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInserir; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_INSERT;
    qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEFAI', VS_strCodEmp);
    qryTemp.ParamByName('CODITE').AsString := FCodIte;
    qryTemp.ParamByName('FAIINI').AsFloat  := FFaixas.FieldByName('ITE_FAIINI').AsFloat;
    qryTemp.ParamByName('FAIFIN').AsFloat  := FFaixas.FieldByName('ITE_FAIFIN').AsFloat;
    qryTemp.ParamByName('ITEFAT').AsFloat  := FFaixas.FieldByName('ITE_ITEFAT').AsFloat;
    qryTemp.ExecSQL();
  end;

  procedure pAlterar; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_UPDATE;
    qryTemp.ParamByName('FAIINI').AsFloat  := FFaixas.FieldByName('ITE_FAIINI').AsFloat;
    qryTemp.ParamByName('FAIFIN').AsFloat  := FFaixas.FieldByName('ITE_FAIFIN').AsFloat;
    qryTemp.ParamByName('ITEFAT').AsFloat  := FFaixas.FieldByName('ITE_ITEFAT').AsFloat;
    qryTemp.ParamByName('AUTINC').AsString := FFaixas.FieldByName('AUTOINCREM').AsString;
    qryTemp.ExecSQL();
  end;

  procedure pExcluir; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_DELETE;
    qryTemp.ParamByName('AUTINC').AsString := FFaixas.FieldByName('AUTOINCREM').AsString;
    qryTemp.ExecSQL();
  end;

begin
  Result := False;

  Try
    qryTemp := fCriaQuery();
    FFaixas.DisableControls();
    FFaixas.Filtered := False;

    fStartTransaction();

    Try
      FFaixas.First();

      While (Not FFaixas.Eof) Do Begin
        If (FFaixas.FieldByName('OPERAC').AsString = 'I') Then
          pInserir()
        Else If (FFaixas.FieldByName('OPERAC').AsString = 'A') Then
          pAlterar()
        Else If (FFaixas.FieldByName('OPERAC').AsString = 'E') Then
          pExcluir();

        FFaixas.Next();
      End;

    	fCommit();
      Result := True;
    Except
      On E: Exception Do Begin
        fRollBack();
        pMensagensErro(E.Message, '[TFaixasMetragem.pCarregarFaixasItem]');
      End;
    End;
  Finally
    pSetFiltro();
    FFaixas.EnableControls();
    FreeAndNil(qryTemp);
  End;
end;

function TFaixasMetragem.fValidarFaixa(fltFaiIni, fltFaiFin, fltIteFat: Double): TCampoValidacao;

  function fFaixaIntervaloExistente: TCampoValidacao;
    Var
      intRecNo: Integer;
      prcScroll: TprcScroll;
  begin
    Result := cvNone;

    Try
      pDisableControls(FFaixas, prcScroll);
      intRecNo := FFaixas.RecNo;
      FFaixas.First();

      While (Not FFaixas.Eof) Do Begin
        If (FFaixas.FieldByName('OPERAC').AsString <> 'E') Then Begin
          If (FAlterando) And (intRecNo = FFaixas.RecNo) Then Begin
            FFaixas.Next();
            Continue;
          End;

          If ( (fltFaiIni > FFaixas.FieldByName('ITE_FAIINI').AsFloat) And (fltFaiIni < FFaixas.FieldByName('ITE_FAIFIN').AsFloat) ) Or
             (fltFaiIni = FFaixas.FieldByName('ITE_FAIINI').AsFloat) Or
             (fltFaiIni = FFaixas.FieldByName('ITE_FAIFIN').AsFloat) Then Begin
            Result := cvIniInterv;
            Break;
          End;

          If ( (fltFaiFin > FFaixas.FieldByName('ITE_FAIINI').AsFloat) And (fltFaiFin < FFaixas.FieldByName('ITE_FAIFIN').AsFloat) ) Or
             (fltFaiFin = FFaixas.FieldByName('ITE_FAIINI').AsFloat) Or
             (fltFaiFin = FFaixas.FieldByName('ITE_FAIINI').AsFloat) Then Begin
            Result := cvFinInterv;
            Break;
          End;

          If ( (fltFaiIni < FFaixas.FieldByName('ITE_FAIINI').AsFloat) And (fltFaiFin > FFaixas.FieldByName('ITE_FAIFIN').AsFloat) ) Then Begin
            Result := cvIntervalo;
            Break;
          End;
        End;

        FFaixas.Next();
      End;

      FFaixas.First();

      While (Not FFaixas.Eof) Do Begin
        If (intRecNo = FFaixas.RecNo) Then
          Break;

        FFaixas.Next();
      End;
    Finally
      pEnableControls(FFaixas, prcScroll);
    End;
  end;

begin
  If (fltFaiIni > fltFaiFin) Then Begin
    fMensagem('ATENÇÃO!', 'A Faixa Inicial deve ser menor que a Faixa Final!', ['&OK']);
    Result := cvFaiIni;
  End Else If (fltIteFat < 1) Then Begin
    fMensagem('ATENÇÃO!', 'O Fator deve ser maior ou igual a 1 (um)!', ['&OK']);
    Result := cvIteFat;
  End Else If (fltFaiFin <= 0) Then Begin
    fMensagem('ATENÇÃO!', 'A Faixa Final deve ser maior que 0 (zero)!', ['&OK']);
    Result := cvFaiFin;
  End Else If (fltFaiIni = fltFaiFin) Then Begin
    fMensagem('ATENÇÃO!', 'As Faixas Inicial e Final devem ser diferentes!', ['&OK']);
    Result := cvFaiIni;
  End Else Begin
    Result := fFaixaIntervaloExistente();

    Case (Result) Of
      cvIniInterv: fMensagem('ATENÇÃO!', 'A Faixa Inicial informada já pertence a um intervalo!', ['&OK']);
      cvFinInterv: fMensagem('ATENÇÃO!', 'A Faixa Final informada já pertence a um intervalo!', ['&OK']);
      cvIntervalo: fMensagem('ATENÇÃO!', 'O intervalo informado é inválido. Verifique!', ['&OK']);
    End;
  End;
end;

procedure TFaixasMetragem.pCarregarFaixasItem;
  Var
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery();
    FFaixas.DisableControls();
    FFaixas.EmptyDataSet();

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := SQL_SELECT;
      qryTemp.ParamByName('CODITE').AsString := FCodIte;
      qryTemp.Open();
      qryTemp.First();

      FFaixas.EmptyDataSet();

      While (Not qryTemp.Eof) Do Begin
        FFaixas.Append();

        FFaixas.FieldByName('AUTOINCREM').AsString := qryTemp.FieldByName('AUTOINCREM').AsString;
        FFaixas.FieldByName('OPERAC').AsString     := 'C'; //consulta
        FFaixas.FieldByName('ITE_FAIINI').AsFloat  := qryTemp.FieldByName('ITE_FAIINI').AsFloat;
        FFaixas.FieldByName('ITE_FAIFIN').AsFloat  := qryTemp.FieldByName('ITE_FAIFIN').AsFloat;
        FFaixas.FieldByName('ITE_ITEFAT').AsFloat  := qryTemp.FieldByName('ITE_ITEFAT').AsFloat;
        FFaixas.FieldByName('ID').AsInteger        := qryTemp.RecNo;

        FFaixas.Post();

        qryTemp.Next();
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TFaixasMetragem.pCarregarFaixasItem]');
    End;
  Finally
    FFaixas.EnableControls();
    FreeAndNil(qryTemp);
  End;
end;

procedure TFaixasMetragem.pCriarClientDataSet;
begin
  With FFaixas.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := True;
  End;

  With FFaixas.FieldDefs.AddFieldDef Do Begin
    Name := 'AUTOINCREM'; DataType := ftString; Size := 20; Required := False;
  End;

  With FFaixas.FieldDefs.AddFieldDef Do Begin
    Name := 'ITE_FAIINI'; DataType := ftFloat; Required := False;
  End;

  With FFaixas.FieldDefs.AddFieldDef Do Begin
    Name := 'ITE_FAIFIN'; DataType := ftFloat; Required := False;
  End;

  With FFaixas.FieldDefs.AddFieldDef Do Begin
    Name := 'ITE_ITEFAT'; DataType := ftFloat; Required := False;
  End;

  With FFaixas.FieldDefs.AddFieldDef Do Begin
    Name := 'OPERAC'; DataType := ftString; Size := 1; Required := False;
  End;

  FFaixas.IndexFieldNames := 'ID';
  FFaixas.CreateDataSet();

  TFloatField(FFaixas.FieldByName('ITE_FAIINI')).DisplayFormat := '#,####0.0000';
  TFloatField(FFaixas.FieldByName('ITE_FAIFIN')).DisplayFormat := '#,####0.0000';
  TFloatField(FFaixas.FieldByName('ITE_ITEFAT')).DisplayFormat := '#,####0.0000';
end;

class procedure TFaixasMetragem.pExcluirFaixas(strCodItem: String);
  Var
    qryTemp: TUniQuery;

  procedure pExcluir; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_DELETE_PROD;
    qryTemp.ParamByName('CODITE').AsString := strCodItem;
    qryTemp.ExecSQL();
  end;

begin
  Try
    qryTemp := fCriaQuery();

    fStartTransaction();

    Try
      pExcluir();

    	fCommit();
    Except
      On E: Exception Do Begin
        fRollBack();
        pMensagensErro(E.Message, '[TFaixasMetragem.pExcluirFaixas]');
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TFaixasMetragem.pSetFiltro;
begin
  FFaixas.Filtered := False;
  FFaixas.Filter   := 'OPERAC <> ' + QuotedStr('E');
  FFaixas.Filtered := True;
end;

end.
