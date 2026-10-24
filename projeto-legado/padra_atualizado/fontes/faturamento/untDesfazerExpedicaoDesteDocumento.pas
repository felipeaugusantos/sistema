unit untDesfazerExpedicaoDesteDocumento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, MemDS,
  DBAccess, Uni, Datasnap.DBClient, UniClientDataSet, untConstantes;

type
  TfrmDesfazerExpedicaoDesteDocumento = class(TfrmPai)
    pnlRodape: TPanel;
    dbgItens: TDBGridCitel;
    btnLimpaExpedicao: TBitBtnLocked;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensSIGUNI: TStringField;
    cdsItensQTDDOC: TFloatField;
    cdsItensQTDEXP: TFloatField;
    cdsItensINCGER: TStringField;
    cdsItensINCDET: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLimpaExpedicaoClick(Sender: TObject);
  private
    { Private declarations }
    function fOrigemDocumento(const strEspDoc: String): String;
  public
    { Public declarations }

    strNumdoc,
    strEspDoc,
    strEmpDoc,
    strCodCli : String;

    function fCarregouDocumento : Boolean;
    function fGetSQL : String;

  end;

implementation

uses
  untFuncoesSimples, untModulo;

{$R *.dfm}

{ TfrmDesfazerExpedicaoDesteDocumento }

procedure TfrmDesfazerExpedicaoDesteDocumento.btnLimpaExpedicaoClick(Sender: TObject);
var
  qryAux : TUniQuery;

const
  strUpdDet = 'UPDATE MOVTRI SET DET_QTDEXP = 0 WHERE DET_SEQGER = :AUTINC';

  strDelSepDet = 'SELECT * FROM SEPDET WHERE DET_SEQGER = :AUTINC';
var
 strAutInc: String;

  function fRetornaSQLUpdateMovGer: String;
  begin
    Result := 'UPDATE   ' +
             '  MOVGER ' +
             'SET      ' +
             '  GER_OPLBEX = NULL, ' +
             '  GER_DTLBEX = NULL, ' +
             '  GER_HRLBEX = NULL  ' +
             IIF(VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA,
             ' , GER_SEPEXP = NULL ' +
             ' , GER_MENEXP = NULL ' +
             ' , GER_OPEEXP = NULL ', EmptyStr)+
             'WHERE                ' +
             '  GER_NUMDOC = :NUMDOC AND ' +
             '  GER_ESPDOC = :ESPDOC AND ' +
             '  GER_CODEMP = :EMPDOC AND ' +
             '  GER_CODCLI = :CODCLI AND ' +
             '  GER_ORIDOC = :ORIDOC ';
  end;

begin

  inherited;

  If (cdsItens.IsEmpty) Then
    Exit;

  If (fMensagem('', 'Deseja limpar expedição do item selecionado?', ['&Sim', '&Não'], 2) = 1) Then
  Begin
    If fUsaRomaneioDocsExpedidos Then
      If fDocumentoEstaEmRomaneio(strNumDoc, strEspDoc, strEmpDoc, strCodCli) Then
        Exit;

    qryAux := fCriaQuery;

    Try
      strAutInc := cdsItensINCDET.AsString;
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strUpdDet);
      qryAux.ParamByName('AUTINC').AsString := strAutInc;

      fStartTransaction;

      Try

        qryAux.ExecSQL;
        cdsItens.Delete;

        If (cdsItens.IsEmpty) Then
        Begin
          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add(fRetornaSQLUpdateMovGer);
          qryAux.ParamByName('NUMDOC').AsString := strNumdoc;
          qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
          qryAux.ParamByName('EMPDOC').AsString := strEmpDoc;
          qryAux.ParamByName('CODCLI').AsString := strCodCli;
          qryAux.ParamByName('ORIDOC').AsString := fOrigemDocumento(strEspDoc);
          qryAux.ExecSQL;
        End;

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(strDelSepDet);
        qryAux.ParamByName('AUTINC').AsString := strAutInc;
        qryAux.Open;
        fVerificaIntegridade('TfrmDesfazerExpedicaoDesteDocumento', 'SEPDET', qryAux, True);

        If qryAux.RecordCount > 0 Then
          qryAux.Delete;

        If (fCommit) Then
          If (cdsItens.IsEmpty) Then
            ModalResult := mrOk;

      Except
        On E: Exception Do
          pMensagensErro(E.Message,'[btnLimpaExpedicaoClick]');
      End;

    Finally
      FreeAndNil(qryAux);
    End;

  End;

end;

function TfrmDesfazerExpedicaoDesteDocumento.fGetSQL: String;
begin

  Result := 'SELECT                     ' +
            '  G.AUTOINCREM AS INCGER,  ' +
            '  D.AUTOINCREM AS INCDET,  ' +
            '  D.DET_CODITE AS CODITE,  ' +
            '  I.ITE_DESITE AS DESITE,  ' +
            '  U.UNI_SIGUNI AS SIGUNI,  ' +
            '  D.DET_QTDITE AS QTDDOC,  ' +
            '  T.DET_QTDEXP AS QTDEXP,  ' +
            '  G.GER_OPLBEX AS OPEEXP,  ' +
            '  G.GER_DTLBEX AS DTAEXP,  ' +
            '  G.GER_HRLBEX AS HOREXP   ' +
            'FROM                       ' +
            '  MOVGER G                 ' +
            '  INNER JOIN MOVDET D ON (D.DET_SEQGER = G.AUTOINCREM) ' +
            '  LEFT  JOIN MOVTRI T ON (T.DET_SEQGER = D.AUTOINCREM) ' +
            '  LEFT  JOIN CADITE I ON (I.ITE_CODITE = D.DET_CODITE) ' +
            '  LEFT  JOIN CADUNI U ON (U.UNI_CODUNI = I.ITE_CODUNI) ' +
            'WHERE G.GER_NUMDOC = :NUMDOC ' +
            '  AND G.GER_ESPDOC = :ESPDOC ' +
            '  AND G.GER_CODEMP = :CODEMP ' +
            '  AND G.GER_CODCLI = :CODCLI ' +
            '  AND G.GER_ORIDOC = :ORIDOC ' +
            '  AND T.DET_QTDEXP > 0       ' +
            'ORDER BY D.DET_CODITE        ';

end;

procedure TfrmDesfazerExpedicaoDesteDocumento.FormCreate(Sender: TObject);
begin
  inherited;
  cdsItens.CreateDataSet;
  cdsItens.EmptyDataSet;
end;

procedure TfrmDesfazerExpedicaoDesteDocumento.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If (Key = VK_F3) Then
    btnLimpaExpedicao.Click;

end;

function TfrmDesfazerExpedicaoDesteDocumento.fCarregouDocumento : Boolean;
var
  qryItens : TUniQuery;
begin

  If fEmptyStr(strNumdoc) Then
    Exit(False);

  If fEmptyStr(strEspDoc) Then
    Exit(False);

  If fEmptyStr(strEmpDoc) Then
    Exit(False);

  If fEmptyStr(strCodCli) Then
    Exit(False);

  cdsItens.EmptyDataSet;

  qryItens := fCriaQuery;

  Try

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add(fGetSQL);
    qryItens.ParamByName('NUMDOC').AsString := strNumdoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := strEmpDoc;
    qryItens.ParamByName('CODCLI').AsString := strCodCli;
    qryItens.ParamByName('ORIDOC').AsString := fOrigemDocumento(strEspDoc);
    qryItens.Open;

    If Not qryItens.IsEmpty Then
    Begin

      qryItens.First;
      While Not qryItens.Eof Do
      Begin

        cdsItens.Append;
        cdsItensINCGER.AsString := qryItens.FieldByName('INCGER').AsString;
        cdsItensINCDET.AsString := qryItens.FieldByName('INCDET').AsString;
        cdsItensCODITE.AsString := qryItens.FieldByName('CODITE').AsString;
        cdsItensDESITE.AsString := qryItens.FieldByName('DESITE').AsString;
        cdsItensSIGUNI.AsString := qryItens.FieldByName('SIGUNI').AsString;
        cdsItensQTDDOC.AsFloat  := qryItens.FieldByName('QTDDOC').AsFloat;
        cdsItensQTDEXP.AsFloat  := qryItens.FieldByName('QTDEXP').AsFloat;
        cdsItens.Post;

        qryItens.Next;

      End;

      cdsItens.First;

    End;

  Finally
    FreeAndNil(qryItens);
  End;

  Result := (cdsItens.RecordCount > 0);

end;

function TfrmDesfazerExpedicaoDesteDocumento.fOrigemDocumento(const strEspDoc: String): String;
begin
  Result := '';

  If (strEspDoc = 'TL') Then
    Exit;

  Result := 'V';
end;

end.
