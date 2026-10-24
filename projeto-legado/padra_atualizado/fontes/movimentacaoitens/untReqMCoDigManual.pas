unit untReqMCoDigManual;

interface

uses
  SysUtils, Classes, DB, UniClientDataSet, Provider, DBEditFocus,
  Controls, Math, frxClass, frxDBset, untZClient;

Type
  TopcEdits = (opcLimpar, opcEditar, opcGravar);

  TMCOReqMaterial = class(TComponent)
  private
    { Private declarations }

      FNumReq,
      FTip_FC,
      FForCli: String;

      Procedure pCriaGerMco;
      Procedure pCriaDetMco(Var zclDetMco: TZClient);
      Procedure pAbreGerMco;
      Procedure pAbreDetMco(zclDetMco: TZClient; strSeqGer: String);
      Procedure pInsertGerMco;
      Procedure pInsertDetMco;
      Procedure pAbreMCO;

      Procedure pCopiaDetIns;
      Procedure pSalvaGerMco(strTip_Fc: String);
      Procedure pCarregaDados;

  protected
    { Protected declarations }
  public
    { Public declarations }

      zclGerMco,
      zclDetMco,
      zclDetIns: TZClient;

      strAutInc: String;
      dtsEdits: TDataSource;

      constructor Create(Owner: TComponent); Reintroduce;
      
      Destructor Destroy; override;

      Function fAlteraRequisicao(strNumReq: String = ''; strTip_FC: String = ''; strForCli: String = ''): Boolean;

      Procedure pCancelaEdicaoItem(opcEdits: TopcEdits = opcLimpar);
      Procedure pCancelaEdicaoRequisicao;
      Procedure pSalvaItem;
      Procedure pEditaItem;
      Procedure pExcluiItem;
      Procedure pSalvaDetMco;

  published
    { Published declarations }
  end;

implementation

Uses
  untReqMaterialConsumoEdit, untFuncoesSimples;

constructor TMCOReqMaterial.Create(Owner: TComponent);
Begin
  Inherited;
  pCriaGerMco;
  pCriaDetMco(zclDetMco);
  pCriaDetMco(zclDetIns);
End;


Procedure TMCOReqMaterial.pCriaGerMco;
Begin
  zclGerMco := TZClient.Create(Self);
  With zclGerMco.qryQuery.SQL Do
  Begin
    Clear;
    Add(' SELECT       ');
    Add(' AUTOINCREM,  ');
    Add(' REQ_NUMREQ,  ');
    Add(' REQ_CODEMP,  ');
    Add(' REQ_DTAENT,  ');
    Add(' REQ_DTAALT,  ');
    Add(' REQ_CODDIG,  ');
    Add(' CAST(REQ_CODDIG AS CHAR(10)) AS CODDIG,  ');
    Add(' REQ_CODENT,  ');
    Add(' REQ_TIP_FC,  ');
    Add(' REQ_FORCLI,  ');
    Add(' REQ_MEN001,  ');
    Add(' REQ_MEN002  ');
    Add(' FROM MOVRQG ');
    Add(' WHERE ');
    Add('  REQ_NUMREQ = :NUMREQ AND ');
    Add('  REQ_TIP_FC = :TIP_FC AND ');
    Add('  REQ_CODEMP = :CODEMP AND ');
    Add('  REQ_FORCLI = :FORCLI     ');
  End;
End;

Procedure TMCOReqMaterial.pCriaDetMco(Var zclDetMco: TZClient);
Begin
  zclDetMco := TZClient.Create(Self);
  With zclDetMco, qryQuery.SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('REQ_SEQGER, ');
    Add('REQ_CODEMP, ');
    Add('REQ_CODMCO, ');
    Add('REQ_QTDMCO, ');
    Add('REQ_UNITAR, ');
    Add('REQ_TOTMCO, ');
    Add('AUTOINCREM, ');
    Add(' (SELECT MCO_DESCRI FROM CADMCO WHERE MCO_CODMCO = REQ_CODMCO) AS REQ_DESCRI ');
    Add('FROM MOVRQD');
    Add('WHERE ');
    Add('  REQ_SEQGER = :SEQGER ');
  End;
End;

Destructor TMCOReqMaterial.Destroy;
Begin
  Inherited;
End;

Procedure TMCOReqMaterial.pAbreGerMco;
Begin
  zclGerMco.Close;
  With zclGerMco.qryQuery Do
  Begin
    Close;
    ParamByName('NUMREQ').AsString := FNumReq;
    ParamByName('TIP_FC').AsString := FTip_FC;
    ParamByName('FORCLI').AsString := FForCli;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    pSetaClient(zclGerMco.qryQuery);

    zclGerMco.pSetProvider;
  End;

  With zclGerMco Do
  Begin

    Open;
    TDateField(FieldByName('REQ_DTAENT')).EditMask   := '99/99/9999';
    TDateField(FieldByName('REQ_DTAALT')).EditMask   := '99/99/9999';

  End;

End;

Procedure TMCOReqMaterial.pAbreDetMco(zclDetMco: TZClient; strSeqGer: String);
Begin
  With zclDetMco, qryQuery Do
  Begin
    Close;

    If zclGerMco.IsEmpty Then
      ParamByName('SEQGER').AsString := ''
    Else
      ParamByName('SEQGER').AsString := strSeqGer;

    Open;

    pSetaClient(qryQuery);
  End;

  With zclDetMco Do
  Begin
    Open;

    FieldByName('REQ_DESCRI').ProviderFlags := [];
    FieldByName('REQ_UNITAR').ProviderFlags := [];
    FieldByName('REQ_TOTMCO').ProviderFlags := [];

    TFloatField(FieldByName('REQ_QTDMCO')).DisplayFormat := '#,##0.0000';
    TFloatField(FieldByName('REQ_UNITAR')).DisplayFormat := '#,##0.0000';
    TFloatField(FieldByName('REQ_TOTMCO')).DisplayFormat    := '#,##0.00';
  End;
End;

Procedure TMCOReqMaterial.pAbreMCO;
Begin
  pAbreGerMco;
  pAbreDetMco(zclDetMco, zclGerMco.FieldByName('AUTOINCREM').AsString);
  pAbreDetMco(zclDetIns, '');
End;

Procedure TMCOReqMaterial.pCancelaEdicaoItem(opcEdits: TopcEdits = opcLimpar);
Begin
  zclDetMco.pCancela(False);
  zclDetIns.pCancela(False);

  Case opcEdits Of
    opcEditar: dtsEdits.DataSet := zclDetMco;
    opcLimpar: pInsertDetMco;
  End;
End;

Procedure TMCOReqMaterial.pInsertGerMco;
Begin
  With zclGerMco Do
  Begin
    If fEmptyStr(FNumReq) Then
    Begin
      Insert;
      FieldByName('REQ_DTAALT').AsDateTime := VS_Date;
      FieldByName('REQ_DTAENT').AsDateTime := VS_Date;
    End Else
    Begin
      Edit;
      FieldByName('REQ_CODDIG').Clear;
      FieldByName('CODDIG').Clear;
      pCarregaDados;
    End;
  End;
End;

Procedure TMCOReqMaterial.pCarregaDados;
Begin
  With frmReqMaterialConsumoEdit, zclGerMco Do
  Begin
    edtNomForCli.Text   := fRetNomFornecedor(FieldByName('REQ_FORCLI').AsString);
    edtNomDig.Text := fRetNomeOperador(FieldByName('REQ_CODDIG').AsString);
    edtNomEnt.Text := fRetNomeMotorista(FieldByName('REQ_CODENT').AsString);
  End;
End;

Procedure TMCOReqMaterial.pInsertDetMco;
Begin
  zclDetIns.pCancela;
  With zclDetIns Do
  Begin
    Insert;
    FieldByName('REQ_QTDMCO').AsFloat := 0;
    FieldByName('REQ_UNITAR').AsFloat := 0;
    FieldByName('REQ_TOTMCO').AsFloat := 0;
  End;
  dtsEdits.DataSet := zclDetIns;
End;

Procedure TMCOReqMaterial.pCopiaDetIns;
  Var
    intContador: Integer;
Begin
  With zclDetIns Do
  Begin
    zclDetMco.Append;

    For intContador := 0 To Fields.Count - 1 Do
      zclDetMco.Fields[intContador].Value := Fields[intContador].Value;

    zclDetMco.Post;

    EmptyDataSet;
  End;

End;

Procedure TMCOReqMaterial.pSalvaItem;
Begin
  If zclDetMco.State = dsEdit Then
  Begin
    zclDetMco.Post;
  End Else
  Begin
    pCopiaDetIns;
  End;

  pInsertDetMco;
End;

Procedure TMCOReqMaterial.pCancelaEdicaoRequisicao;
Begin
  zclGerMco.pCancela;
  zclDetMco.pCancela;
End;

Procedure TMCOReqMaterial.pSalvaGerMco(strTip_Fc: String);
Begin
  With zclGerMco Do
  If State In [dsEdit, dsInsert] Then
  Begin
    FieldByName('REQ_TIP_FC').AsString := strTip_Fc;
    If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
    Begin
      FieldByName('REQ_NUMREQ').AsString := fRetSequencial('PRO_MC', '', 12);
      FieldByName('REQ_CODEMP').AsString := VS_strCodEmp;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MOVRQG', VS_strCodEmp);
    End;

    If Modified Or (zclDetMco.ChangeCount > 0) Then
    Begin
      FieldByName('REQ_DTAALT').AsDateTime := VS_Date;
      FieldByName('CODDIG').AsString   := frmReqMaterialConsumoEdit.dbeCodDig.Text;
    End;

    FieldByName('REQ_CODDIG').AsString   := fRetCodVendedor(FieldByName('CODDIG').AsString);
    Post;
  End;

  pSalvaDetMco;
End;

Procedure TMCOReqMaterial.pSalvaDetMco;
Begin
  With zclDetMco Do
  Begin
    First;
    While Not Eof Do
    Begin
      If fEmptyStr(FieldByName('REQ_SEQGER').AsString) Then
      Begin
        Edit;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MOVRQD', VS_strCodEmp);
        FieldByName('REQ_SEQGER').AsString := zclGerMco.FieldByName('AUTOINCREM').AsString;
        FieldByName('REQ_CODEMP').AsString := zclGerMco.FieldByName('REQ_CODEMP').AsString;
        Post;
      End;

      Next;
    End;
  End;
End;

Function TMCOReqMaterial.fAlteraRequisicao(strNumReq: String = '';
  strTip_FC: String = ''; strForCli: String = ''): Boolean;
Begin
  Result  := False;
  FNumReq := strNumReq;
  FTip_FC := strTip_FC;
  FForCli := strForCli;

  pAbreMCO;
  pCriarFormularios(TfrmReqMaterialConsumoEdit, frmReqMaterialConsumoEdit);

  With frmReqMaterialConsumoEdit Do
  Begin
    objMCODig := Self;
    pInsertGerMco;

    If ShowModal = mrOk Then
    Begin
    
      Try
        pSalvaGerMco('F');
        
        fStartTransaction;

        If zclGerMco.fSalva And zclDetMco.fSalva Then
          fCommit
        Else
          fRollBack;

        strAutInc := zclGerMco.FieldByName('AUTOINCREM').AsString;

        Result := True;

      Except
        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message,'[TRegMcoDigManual.pAlteraRequisicao]');
        End;
      End;

    End Else
    Begin
      pCancelaEdicaoRequisicao;
    End;
  End;
  FreeAndNil(frmReqMaterialConsumoEdit);
End;

Procedure TMCOReqMaterial.pEditaItem;
Begin
  If dtsEdits.DataSet = zclDetIns Then
  Begin
    pInsertDetMco;
  End Else
  Begin
    zclDetMco.Edit;
  End;
End;

Procedure TMCOReqMaterial.pExcluiItem;
Begin
  With zclDetMco Do
  Begin
    If IsEmpty Then
      Exit;

    If fPergunta('Confirma a exclusão do material?') Then
      Delete;
  End;
End;

end.
