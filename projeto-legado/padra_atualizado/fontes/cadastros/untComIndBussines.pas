unit untComIndBussines;

interface

uses SysUtils, StrUtils, UniClientDataSet, UniDataSetProvider, untComIndDao,
  Uni, DB, Math, Classes;

Type
  TAcaoObjeto = (aoInserindo, aoEditando, aoDeletando, aoNone);

type
  TComIndBussines = Class(TObject)
  private
    FComIndDao: TComIndDao;
    FdspAti: TUniDataSetProvider;
    FdspNAt: TUniDataSetProvider;
    procedure pMostraFaixaValorCadastras(strTabela: String);
  public
    destructor Destroy; override;

    function fGravaMetaAtingida(cdsComIndAti: TUniClientDataSet): Boolean;
    function fGravaMetaNaoAtingida(cdsComIndNAt: TUniClientDataSet): Boolean;

    function fGetClientComIndAti: TUniClientDataSet;
    function fGetClientComIndNAt: TUniClientDataSet;
    function fGetMetaFaturamento: Double;

    function fValidaValorInvidual(fltValor: Double;
                                  fltValorOld: Double;
                                  aoTipoAcao: TAcaoObjeto;
                                  strTabela: String;
                                  strAutInc: String;
                                  cdsDados: TUniClientDataSet): Boolean;
    function fValidaFaixaValor(fltValorIni, fltValorFin: Double;
                               fltValorIniOld, fltValorFinOld: Double;
                               aoTipoAcao: TAcaoObjeto;
                               strTabela: String;
                               strAutInc: String;
                               cdsDados: TUniClientDataSet): Boolean;
  end;

implementation

uses  untFuncoesSimples, untMemo;

{ TComIndBussines }

function TComIndBussines.fGravaMetaAtingida(cdsComIndAti: TUniClientDataSet): Boolean;
begin
  FComIndDao := TComIndDao.Create;
  Result := FComIndDao.fGravaMetaAtingida(cdsComIndAti);
  FComIndDao.Free;
end;

function TComIndBussines.fGravaMetaNaoAtingida(cdsComIndNAt: TUniClientDataSet): Boolean;
begin
  FComIndDao := TComIndDao.Create;
  Result := FComIndDao.fGravaMetaNaoAtingida(cdsComIndNAt);
  FComIndDao.Free;
end;

function TComIndBussines.fValidaFaixaValor(fltValorIni, fltValorFin,
  fltValorIniOld, fltValorFinOld: Double; aoTipoAcao: TAcaoObjeto;
  strTabela: String; strAutInc: String; cdsDados: TUniClientDataSet): Boolean;
  Var
    cdsTmp: TUniClientDataSet;

  function fVerificaCampo: Boolean;
  Begin
    Result := True;
    
    With cdsTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        If SameText(FieldByName('AUTOINCREM').AsString, strAutInc) Then
        Begin
          Next;
          Continue;
        End;
          
        If (RoundTo(fltValorIni, -2) >= RoundTo(FieldByName('COM_VALINI').AsFloat, -2)) Then
        Begin
          If (RoundTo(fltValorFin, -2) <= RoundTo(FieldByName('COM_VALFIN').AsFloat, -2)) Then
          Begin
            Result := False;
            Break;
          End;
        End;

        Next;
      End;
    End;
  End;
begin
  Result := True;

  Try
    If (aoTipoAcao = aoEditando) And
       (RoundTo(fltValorIni, -2) = RoundTo(fltValorIniOld, -2)) And
       (RoundTo(fltValorFin, -2) = RoundTo(fltValorFinOld, -2)) Then
      Exit;

    cdsTmp := TUniClientDataSet.Create(Nil);
    pCloneDataSet(cdsTmp, cdsDados);

    With cdsTmp Do
    Begin
      Open;

      If Not IsEmpty Then
      Begin
        Result := fVerificaCampo;

        If (Not Result) Then
        Begin
          fMensagem('ATENÇÃO', 'Já existe um % de comissão cadastrado para essa faixa de valor!', ['&Ok']);
          pMostraFaixaValorCadastras(strTabela);
        End;
      End;
    End;

    FreeAndNil(cdsTmp);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fValidaFaixaValor]');
  End;
end;

function TComIndBussines.fValidaValorInvidual(fltValor,
  fltValorOld: Double; aoTipoAcao: TAcaoObjeto; strTabela: String;
  strAutInc: String; cdsDados: TUniClientDataSet): Boolean;
  Var
    cdsTmp: TUniClientDataSet;

  function fVerificaCampo: Boolean;
  Begin
    Result := True;
    
    With cdsTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        If SameText(FieldByName('AUTOINCREM').AsString, strAutInc) Then
        Begin
          Next;
          Continue;
        End;

        If (RoundTo(fltValor, -2) >= RoundTo(FieldByName('COM_VALINI').AsFloat, -2)) And
           (RoundTo(fltValor, -2) <= RoundTo(FieldByName('COM_VALFIN').AsFloat, -2)) Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;
    End;
  End;

begin
  Result := True;

  Try
    If (aoTipoAcao = aoEditando) And
       (RoundTo(fltValor, -2) = RoundTo(fltValorOld, -2)) Then
      Exit;

    cdsTmp := TUniClientDataSet.Create(Nil);
    pCloneDataSet(cdsTmp, cdsDados);

    With cdsTmp Do
    Begin
      Open;

      If Not IsEmpty Then
      Begin
        Result := fVerificaCampo;

        If (Not Result) Then
        Begin
          fMensagem('ATENÇÃO', 'Já existe um % de comissão cadastrado para essa faixa de valor!', ['&Ok']);
          pMostraFaixaValorCadastras(strTabela);
        End;
      End;
    End;

    FreeAndNil(cdsTmp);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[fValidaValorInvidual]');
  End;
end;

procedure TComIndBussines.pMostraFaixaValorCadastras(strTabela: String);
  Var
    qryTmp: TUniQuery;
    strSQL: String;
    lstLista: TStringList;
begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COM_DESCRI, ';
    strSQL := strSQL + '   COM_VALINI, ';
    strSQL := strSQL + '   COM_VALFIN, ';
    strSQL := strSQL + '   COM_PERCOM  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strTabela;

    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      If Not IsEmpty Then
      Begin
        lstLista := TStringList.Create;

        lstLista.Add('-----------------------------------------------------------------------');
        lstLista.Add('               FAIXA DE ÍNDICES PARA COMISSÃO CADASTRADOS              ');
        lstLista.Add('-----------------------------------------------------------------------');
        lstLista.Add('  DESCRIÇÃO                    | VLR. INICIAL | VLR. FINAL   |  COM. % ');
        lstLista.Add('-----------------------------------------------------------------------');

        First;
        while Not Eof Do
        Begin
          lstLista.Add(' ' + fPadR(FieldByName('COM_DESCRI').AsString,28) + ' | ' +
                             fPadL(FormatFloat('#,##0.00',FieldByName('COM_VALINI').AsFloat),12) + ' | ' +
                             fPadL(FormatFloat('#,##0.00',FieldByName('COM_VALFIN').AsFloat),12) + ' | ' +
                             fPadL(FormatFloat('#,##0.00',FieldByName('COM_PERCOM').AsFloat),7) + '%');
          Next;
        end;

        lstLista.Add('-----------------------------------------------------------------------');

        pCriarFormularios(TfrmMemo, frmMemo);
        frmMemo.cxMemo.Style.Font.Style := [];
        frmMemo.cxMemo.Lines := lstLista;
        frmMemo.ShowModal;

        FreeAndNil(lstLista);
        pFreeAndNil(frmMemo);
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + '[pMostraFaixaValorCadastras]');
  End;

  FreeAndNil(qryTmp);
end;

destructor TComIndBussines.Destroy;
begin
  FreeAndNil(FdspAti);
  FreeAndNil(FdspNAt);
end;

function TComIndBussines.fGetClientComIndAti: TUniClientDataSet;
begin
  FComIndDao := TComIndDao.Create;
  Result := TUniClientDataSet.Create(Nil);
  FdspAti := TUniDataSetProvider.Create(Nil);
  FdspAti.DataSet := FComIndDao.fGetAllComInd('COMIAT');
  Result.SetProvider(FdspAti);
  Result.Open;
  pSetaClient(Result);
  FComIndDao.Free;
end;

function TComIndBussines.fGetClientComIndNAt: TUniClientDataSet;
begin
  FComIndDao := TComIndDao.Create;
  Result := TUniClientDataSet.Create(Nil);
  FdspNAt := TUniDataSetProvider.Create(Nil);
  FdspNAt.DataSet := FComIndDao.fGetAllComInd('COMINT');
  Result.SetProvider(FdspNAt);
  Result.Open;
  pSetaClient(Result);
  FComIndDao.Free;
end;

function TComIndBussines.fGetMetaFaturamento: Double;
begin
  FComIndDao := TComIndDao.Create;
  Result := FComIndDao.fGetMetaFaturamento;
  FComIndDao.Free;
end;

end.
