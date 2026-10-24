unit untTBaixaReceber;

interface

uses System.Classes, System.SysUtils, System.StrUtils,
     System.Generics.Collections, Data.DB, System.Threading, System.Variants,
     Vcl.Forms, Uni, UniClientDataset;

Type
  TBaixaReceber = Class(TComponent)
  Private
    lstCtrCbi: TStringList;

    FDatasetMarcados: TUniClientDataset;
  Public
    procedure pCarregaListSelecionadas(Data: OleVariant);
    procedure pCarregaListSelecionada(Data: String);
    procedure pLimparListSelecionada;

    function fAnalizaCadCbi: Boolean;
    function fAnalizaCadCbiCtr: Boolean;
    constructor Create(Owner: TComponent); Override;
    destructor Destroy; Override;
  End;

implementation

uses untFuncoesSimples, untFinDesmRemBanc, untFuncAutBan;

{ TBaixaReceber }

constructor TBaixaReceber.Create(Owner: TComponent);
begin
  inherited;
  FDatasetMarcados := TUniClientDataset.Create(Nil);
  lstCtrCbi := TStringList.Create;
end;

destructor TBaixaReceber.Destroy;
begin
  FreeAndNil(FDatasetMarcados);
  If Assigned(lstCtrCbi) Then
    FreeAndNil(lstCtrCbi);
  inherited;
end;

function TBaixaReceber.fAnalizaCadCbi: Boolean;
  Var
    lstRecCbi: TStringList;

    frmFinDesmRemBanc : TfrmFinDesmRemBanc;
begin
  Result := True;

  If FDatasetMarcados.IsEmpty Then
    Exit;

  lstRecCbi := TStringList.Create;

  FDatasetMarcados.First;
  While Not FDatasetMarcados.Eof Do
  Begin
    If untFuncAutBan.fTemNaCadCbi(FDatasetMarcados.FieldByName('NRODUP').AsString,
                                  FDatasetMarcados.FieldByName('CTR_ESPDOC').AsString,
                                  FDatasetMarcados.FieldByName('PARDUP').AsString,
                                  FDatasetMarcados.FieldByName('CTR_CODEMP').AsString,
                                  FDatasetMarcados.FieldByName('CTR_CODCLI').AsString,
                                  EmptyStr) Then
      lstRecCbi.Add(Concat(FDatasetMarcados.FieldByName('NRODUP').AsString, '-',
                           FDatasetMarcados.FieldByName('PARDUP').AsString, '-',
                           FDatasetMarcados.FieldByName('CTR_ESPDOC').AsString, '-',
                           FDatasetMarcados.FieldByName('CTR_CODEMP').AsString, '-',
                           FDatasetMarcados.FieldByName('CTR_CODCLI').AsString));

    FDatasetMarcados.Next;
  End;

  If lstRecCbi.Count > 0 Then
  Begin

    If fMensagem('', 'Existem uma ou mais duplicatas selecionadas que foram separadas para serem enviadas para o banco.' + #13#10 +
                     'É necessário o cancelamento das mesmas. Deseja efetuar o cancelamento agora?', ['','']) = 1 Then
    Begin

      If fVerificaAcessoSistema('frmFinDesmRemBanc') Then
      Begin
        Try
          Application.CreateForm(TfrmFinDesmRemBanc, frmFinDesmRemBanc);
          frmFinDesmRemBanc.lstRecCbi := lstRecCbi;
          frmFinDesmRemBanc.ShowModal;

          If lstRecCbi.Count > 0 Then
          Begin
            pMensagemOk('Não foram canceladas todas as duplicatas, favor desmarcá-las!');
            Result := False;
          End;

        Except
          On E: Exception Do
            Raise Exception.Create(E.Message);
        End;
        FreeAndNil(frmFinDesmRemBanc);

      End
      Else
      Begin
        pMensagemOk('Sem permissão de acesso para restaurar remessa!');
        Result := False;
      End;

    End
    Else
      Result := False;

  End;

end;

function TBaixaReceber.fAnalizaCadCbiCtr: Boolean;
  Var
    frmFinDesmRemBanc : TfrmFinDesmRemBanc;
begin
  Result := True;
  If ((lstCtrCbi.Count > 0) And Not fEmptyStr(lstCtrCbi.Text)) Then
  Begin

    If fMensagem('', 'Existem uma ou mais duplicatas selecionadas que foram separadas para serem enviadas para o banco.' + #13#10 +
                     'É necessário o cancelamento das mesmas. Deseja efetuar o cancelamento agora?', ['','']) = 1 Then
    Begin

      If fVerificaAcessoSistema('frmFinDesmRemBanc') Then
      Begin
        Try
          Application.CreateForm(TfrmFinDesmRemBanc, frmFinDesmRemBanc);
          frmFinDesmRemBanc.lstRecCbi := lstCtrCbi;
          frmFinDesmRemBanc.ShowModal;

          If frmFinDesmRemBanc.lstRecCbi.Count > 0 Then
          Begin
            pMensagemOk('Não foram canceladas todas as duplicatas, favor desmarcá-las!');
            Result := False;
          End;

        Except
          On E: Exception Do
            Raise Exception.Create(E.Message);
        End;
        FreeAndNil(frmFinDesmRemBanc);

      End
      Else
      Begin
        pMensagemOk('Sem permissão de acesso para restaurar remessa!');
        Result := False;
      End;

    End
    Else
      Result := False;

  End;
end;

procedure TBaixaReceber.pCarregaListSelecionada(Data: String);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriarQuery('SELECT * FROM CADREC WHERE AUTOINCREM="' + Data + '"');

  Try
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    If untFuncAutBan.fTemNaCadCbi(LConsulta.FieldByName('CTR_NUMDUP').AsString,
                                  LConsulta.FieldByName('CTR_ESPDOC').AsString,
                                  LConsulta.FieldByName('CTR_PARCEL').AsString,
                                  LConsulta.FieldByName('CTR_CODEMP').AsString,
                                  LConsulta.FieldByName('CTR_CODCLI').AsString,
                                  EmptyStr) Then
      lstCtrCbi.Add(Concat(LConsulta.FieldByName('CTR_NUMDUP').AsString, '-',
                           LConsulta.FieldByName('CTR_PARCEL').AsString, '-',
                           LConsulta.FieldByName('CTR_ESPDOC').AsString, '-',
                           LConsulta.FieldByName('CTR_CODEMP').AsString, '-',
                           LConsulta.FieldByName('CTR_CODCLI').AsString));
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

procedure TBaixaReceber.pCarregaListSelecionadas(Data: OleVariant);
begin
  If Not FDatasetMarcados.IsEmpty Then
    FDatasetMarcados.EmptyDataSet;

  FDatasetMarcados := TUniClientDataSet.Create(Nil);
  FDatasetMarcados.Data := Data;
  FDatasetMarcados.Filtered := False;
  FDatasetMarcados.Filter := 'CTR_MARDES = ''M''';
  FDatasetMarcados.Filtered := True;
end;

procedure TBaixaReceber.pLimparListSelecionada;
begin
  If lstCtrCbi.Count > 0 Then
    lstCtrCbi.Clear;
end;

end.
