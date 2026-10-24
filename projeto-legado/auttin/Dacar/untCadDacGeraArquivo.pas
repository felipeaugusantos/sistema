unit untCadDacGeraArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, AppEvnts, Uni, ADODB, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadDacGeraArquivo = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    tmrProgresso: TTimer;
    pnlProgresso: TPanel;
    pnlCentral: TPanel;
    pnlProgInterno: TPanel;
    rbBaseCol: TRadioButton;
    rbTintas: TRadioButton;
    btnConfirmaGeracao: TBitBtnLocked;
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure tmrProgressoTimer(Sender: TObject);
  private
    { Private declarations }
    strDirecao: String;
    function fRetornaEmbalagem(strEmbalagem: String): String;
    function fRetornaCodCol(strColorante: String): String;
    function fRetornaQtdCol(strColorante: String): String;
    function fRetornaCodFml(strProduto: String): String;
  public
    { Public declarations }
    function fDacarGeraArquivoAntigo: Boolean;
    function fProcessaArquivoAntigo : Boolean;
    function fDacarGeraArquivoNovo: Boolean;
    function fProcessaArquivoNovo : Boolean;
  end;

var
  frmCadDacGeraArquivo: TfrmCadDacGeraArquivo;

implementation

uses untDacar, untFuncoesSimples,
     untIConfTinta, untFuncTinta, untDacarImobiliaria;

{$R *.dfm}

procedure TfrmCadDacGeraArquivo.btnConfirmaGeracaoClick(Sender: TObject);
Var
  conf: IConfTinta;
begin
  inherited;

  conf := fGetConfTinta('DAC');

  If (fMensagem('', 'Confirma geração do arquivo?', ['&Sim', '&Não']) = 1) Then
  Begin
    pnlInfo.Caption := 'Gerando arquivo (DACAR), aguarde...';
    Application.ProcessMessages;
    btnConfirmaGeracao.Enabled := False;
    btnSair.Enabled            := False;
    tmrProgresso.Enabled := True;
    If rbBaseCol.Checked Then
    Begin
      If conf.fGetBoolean('GERANT') Then
      Begin
        If  fDacarGeraArquivoAntigo Then
          fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
      End
      Else
      Begin
        If fDacarGeraArquivoNovo Then
          fMensagem('', 'Arquivo gerado com sucesso!', ['&Ok']);
      End;
    End
    Else
    Begin
      If conf.fGetBoolean('GERANT') Then
      Begin
        If  fProcessaArquivoAntigo Then
          fMensagem('', 'Arquivo processado com sucesso!', ['&Ok']);
      End
      Else
      Begin
        If fProcessaArquivoNovo Then
          fMensagem('', 'Arquivo processado com sucesso!', ['&Ok']);
      End;
    End;
    tmrProgresso.Enabled := False;
    pnlInfo.Caption := '';
    Close;
  End;
end;

function TfrmCadDacGeraArquivo.fDacarGeraArquivoAntigo: Boolean;
  Var
    Excel     : TADODataSet;
    Conexao   : TADOConnection;
    strPatDac : String;
    Planilhas : TStringList;
    intCont   : Integer;
    qryCadBas : TUniQuery;
    qryCadCol : TUniQuery;
    conf      : IConfTinta;
begin
  Result := True;
  conf   := fGetConfTinta('DAC');
  strPatDac := conf.fGet('TXTDAC'); //fArqIniTinta(0, 'DACAR', 'TXTDAC', '');
  If (Not FileExists(strPatDac)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPatDac, ['&Ok']);
    Result := False;
    Exit;
  End;

  Conexao := TADOConnection.Create(nil);
  Conexao.LoginPrompt := False;
  Conexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
                              strPatDac +
                              ';Extended Properties="Excel 8.0;"';
  Conexao.Open;
  Excel := TADODataSet.Create(nil);
  Excel.Connection := Conexao;

  Planilhas := TStringList.Create;
  Conexao.GetTableNames(Planilhas);

  Excel.CommandText := ' SELECT DISTINCT [CÓDIGO PRODUTO], [BASE], [EMBALAGEM], [PRODUTO] ' +
                       Format(' FROM [%s] ', [Planilhas.Strings[0]]);
  For intCont := 1 To Planilhas.Count - 1 Do
  Begin
    Excel.CommandText := Excel.CommandText + ' UNION ' +
                                             'SELECT DISTINCT [CÓDIGO PRODUTO], [BASE], [EMBALAGEM], [PRODUTO] ' +
                                             Format(' FROM [%s] ', [Planilhas.Strings[intCont]]);
  End;
  Excel.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * FROM DAC_CADBAS';
  qryCadBas.Open;

  Excel.First;
  For intCont := 1 To Excel.RecordCount Do
  Begin
    If not qryCadBas.Locate('BAS_BASE__;BAS_CODFML;BAS_UNIDAD',
            VarArrayOf([Excel.FieldByName('BASE').AsString,
                        Excel.FieldByName('CÓDIGO PRODUTO').AsString,
                        Excel.FieldByName('EMBALAGEM').AsString]), []) Then
    Begin
      qryCadBas.Insert;
        qryCadBas.FieldByName('BAS_BASE__').AsString := Excel.FieldByName('BASE').AsString;
        qryCadBas.FieldByName('BAS_DESCRI').AsString := Excel.FieldByName('PRODUTO').AsString;
        qryCadBas.FieldByName('BAS_UNIDAD').AsString := Excel.FieldByName('EMBALAGEM').AsString;
        qryCadBas.FieldByName('BAS_CODFML').AsString := Excel.FieldByName('CÓDIGO PRODUTO').AsString;
        qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DAC_CADBAS', VS_strCodEmp);
      qryCadBas.Post;
    End;
    pnlInfo.Caption := Format('Gerando Arquivo (%d/%d)', [Excel.RecNo, Excel.RecordCount]);
    Application.ProcessMessages;
    Excel.Next;
  End;

  qryCadCol := fCriaQuery;
  qryCadCol.SQL.Text := 'SELECT * FROM DAC_CADCOL';
  qryCadCol.Open;

  Excel.Close;
  Excel.CommandText := ' SELECT DISTINCT [CORANTE] ' +
                       Format(' FROM [%s] ', [Planilhas.Strings[0]]);
  For intCont := 1 To Planilhas.Count - 1 Do
  Begin
    Excel.CommandText := Excel.CommandText + ' UNION ' +
                                             'SELECT DISTINCT [CORANTE] ' +
                                             Format(' FROM [%s] ', [Planilhas.Strings[intCont]]);
  End;
  Excel.Open;
  Excel.First;
  For intCont := 1 To Excel.RecordCount Do
  Begin
    If not qryCadCol.Locate('COL_CODCOL', Excel.FieldByName('CORANTE').AsString, []) Then
    Begin
      qryCadCol.Insert;
      qryCadCol.FieldByName('COL_CODCOL').AsString := Excel.FieldByName('CORANTE').AsString;
      qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DAC_CADCOL', VS_strCodEmp);
      qryCadCol.Post;
    End;
    pnlInfo.Caption := Format('Gerando Arquivo (%d/%d)', [Excel.RecNo, Excel.RecordCount]);
    Application.ProcessMessages;
    Excel.Next;
  End;
  Excel.Close;
  Conexao.Close;
  FreeAndNil(Excel);
  FreeAndNil(Conexao);
  FreeAndNil(Planilhas);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);
end;

function TfrmCadDacGeraArquivo.fDacarGeraArquivoNovo: Boolean;
  Var
    Excel     : TADODataSet;
    Conexao   : TADOConnection;
    strPatDac : String;
    intContCol: Integer;
    qryCadBas : TUniQuery;
    qryCadCol : TUniQuery;
    conf      : IConfTinta;
    Planilhas : TStringList;
begin
  Result := True;
  conf   := fGetConfTinta('DAC');
  strPatDac := conf.fGet('TXTDAC'); //fArqIniTinta(0, 'DACAR', 'TXTDAC', '');
  If (Not FileExists(strPatDac)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPatDac, ['&Ok']);
    Result := False;
    Exit;
  End;

  Conexao := TADOConnection.Create(nil);
  Conexao.LoginPrompt := False;
  Conexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
                              strPatDac +
                              ';Extended Properties="Excel 8.0;"';
  Conexao.Open;
  Excel := TADODataSet.Create(nil);
  Excel.Connection := Conexao;

  Planilhas := TStringList.Create;
  Conexao.GetTableNames(Planilhas);

  //ACRILICO MEGA
  Excel.CommandText := 'SELECT DISTINCT [BASE], [EMBALAGEM], ''ACRILICO MEGA'' AS [PRODUTO] ' +
                       Format(' FROM [%s] ', [Planilhas.Strings[0]]) ;

  //SERVCOR 3
  Excel.CommandText := Excel.CommandText + ' UNION ' +
                       'SELECT DISTINCT [BASE], [EMBALAGEM], [PRODUTO] ' +
                       Format(' FROM [%s] ', [Planilhas.Strings[1]]);
  Excel.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT * FROM DAC_CADBAS';
  qryCadBas.Open;

  Excel.First;
  While Not Excel.Eof Do
  Begin
    If (Not fEmptyStr(Excel.FieldByName('BASE').AsString)) And
       (not qryCadBas.Locate('BAS_BASE__;BAS_CODFML;BAS_UNIDAD',
            VarArrayOf([Excel.FieldByName('BASE').AsString,
                        fRetornaCodFml(Excel.FieldByName('PRODUTO').AsString),
                        Excel.FieldByName('EMBALAGEM').AsString]), [])) Then
    Begin
      qryCadBas.Insert;
        qryCadBas.FieldByName('BAS_BASE__').AsString := Excel.FieldByName('BASE').AsString;
        qryCadBas.FieldByName('BAS_DESCRI').AsString := Excel.FieldByName('PRODUTO').AsString;
        qryCadBas.FieldByName('BAS_UNIDAD').AsString := fRetornaEmbalagem(Excel.FieldByName('EMBALAGEM').AsString);
        qryCadBas.FieldByName('BAS_CODFML').AsString := fRetornaCodFml(Excel.FieldByName('PRODUTO').AsString);
        qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
        qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DAC_CADBAS', VS_strCodEmp);
      qryCadBas.Post;
    End;
    pnlInfo.Caption := Format('Gerando Arquivo (%d/%d)', [Excel.RecNo, Excel.RecordCount]);
    Application.ProcessMessages;
    Excel.Next;
  End;

  qryCadCol := fCriaQuery;
  qryCadCol.SQL.Text := 'SELECT * FROM DAC_CADCOL';
  qryCadCol.Open;

  Excel.Close;
  Excel.CommandText := ' SELECT DISTINCT [CORANTE] AS [CORANTE1], '''' AS [CORANTE2], '''' AS [CORANTE3], '''' AS [CORANTE4]' +
                       Format(' FROM [%s] ', [Planilhas.Strings[0]]);

  Excel.CommandText := Excel.CommandText + ' UNION ' +
                       'SELECT DISTINCT [CORANTE1], [CORANTE2], [CORANTE3], [CORANTE4] ' +
                       Format(' FROM [%s] ', [Planilhas.Strings[1]]);

  Excel.Open;
  Excel.First;

  While Not Excel.Eof Do
  Begin
    For intContCol := 1 To 4 Do
    Begin
      If (Not fEmptyStr(fRetornaCodCol(Excel.FieldByName('CORANTE' + IntToStr(intContCol)).AsString))) And
         (Not qryCadCol.Locate('COL_CODCOL;COL_CODEMP',  VarArrayOf([fRetornaCodCol(Excel.FieldByName('CORANTE' + IntToStr(intContCol)).AsString), VS_strCodEmp]), [])) Then
      Begin
        qryCadCol.Insert;
        qryCadCol.FieldByName('COL_CODCOL').AsString := fRetornaCodCol(Excel.FieldByName('CORANTE' + IntToStr(intContCol)).AsString);
        qryCadCol.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
        qryCadCol.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DAC_CADCOL', VS_strCodEmp);
        qryCadCol.Post;
      End;
    End;
    pnlInfo.Caption := Format('Gerando Arquivo (%d/%d)', [Excel.RecNo, Excel.RecordCount]);
    Application.ProcessMessages;
    Excel.Next;
  End;

  Excel.Close;
  Conexao.Close;
  FreeAndNil(Excel);
  FreeAndNil(Conexao);
  FreeAndNil(Planilhas);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadCol);
end;

function TfrmCadDacGeraArquivo.fProcessaArquivoAntigo: Boolean;
  Var
    Excel : TADODataSet;
    Conexao : TADOConnection;
    Planilhas : TStringList;
    intPlan   : Integer;

    qryCadDac : TUniQuery;
    qryCadBas : TUniQuery;
    intForm   : Integer;
    qryCadNfm : TUniQuery;
    qryCadUni : TUniQuery;
    qryCadCol : TUniQuery;

    intCodSeq : Integer;
    intCont   : Integer;
    strCodCor : String;
    strPatDac : String;
    strNomCor : String;
    strCodPro : String;
    strBase   : String;
    strEmbala : String;

    intTemp   : Integer;
    fltInicio : Double;
    conf: IConfTinta;
begin
  Result := True;
  conf   := fGetConfTinta('DAC');
  intForm := 0;
  strPatDac := conf.fGet('TXTDAC'); //fArqIniTinta(0, 'DACAR', 'TXTDAC', '');
  
  If (Not FileExists(strPatDac)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPatDac, ['&Ok']);
    Result := False;
    Exit;
  End;

  Conexao := TADOConnection.Create(nil);
  Conexao.LoginPrompt := False;
  Conexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
                              strPatDac +
                              ';Extended Properties="Excel 8.0;HDR=No;IMEX=1"';
  Conexao.Open;
  Excel := TADODataSet.Create(nil);
  Excel.Connection := Conexao;

  Planilhas := TStringList.Create;
  Conexao.GetTableNames(Planilhas);
  pLimparTabela('DAC_CADDAC');

  qryCadDac := fCriaQuery;
  qryCadDac.SQL.Text := 'SELECT * FROM DAC_CADDAC';
  qryCadDac.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT DISTINCT * FROM DAC_CADBAS';
  qryCadBas.Open;

  qryCadUni := fCriaQuery;
  qryCadUni.SQL.Text := 'SELECT DAC_UNIDAC, DAC_UNIAUT FROM DAC_UNIDAC';
  qryCadUni.Open;

  If qryCadUni.IsEmpty Then
  Begin
    fMensagem('', 'A Relação das unidades não está configurada', ['OK']);
    Result := False;
    Exit;
  End;

  qryCadCol := fCriaQuery;
  qryCadCol.SQL.Text := 'SELECT COL_CODCOL, COL_CODITE FROM DAC_CADCOL';
  qryCadCol.Open;

  If qryCadCol.IsEmpty Then
  Begin
    fMensagem('', 'Não existe colorantes cadastrados', ['OK']);
    Result := False;
    Exit;
  End;

  intCodSeq := 1;

  strCodCor := '';

  intTemp := 1;
  fltInicio := fNow();

  For intPlan := 0 To Planilhas.Count - 1 Do
  Begin
    Excel.Close;
    Excel.CommandText := ' SELECT F1, F2, F3, F4, F5, F6, F7, F8, F9  ' +
                       Format(' FROM [%s] ', [Planilhas.Strings[intPlan]]) +
                       ' WHERE F1 <> "COLEÇÃO" ';
    Excel.Open;
    Excel.First;

    For intCont := 1 To Excel.RecordCount Do
    Begin
      If (strCodCor <> Excel.FieldByName('F2').AsString) or
         (strCodPro <> Excel.FieldByName('F4').AsString) or
         (strBase   <> Excel.FieldByName('F5').AsString) or
         (strEmbala <> Excel.FieldByName('F6').AsString) or
         (strNomCor <> Excel.FieldByName('F3').AsString) Then
      Begin
        If qryCadDac.State = dsInsert Then
          qryCadDac.Post;
        If not qryCadBas.Locate('BAS_BASE__;BAS_CODFML;BAS_UNIDAD',
            VarArrayOf([Excel.FieldByName('F5').AsString,
                        Excel.FieldByName('F4').AsString,
                        Excel.FieldByName('F6').AsString]), []) Then
        Begin
//          fMensagem('','Base Não Cadastrada',['OK']);
//          Result := False;
//          Break;
//          Exit;
          Excel.Next;
          Continue;
        End;

        If Not qryCadUni.Locate('DAC_UNIDAC', Excel.FieldByName('F6').AsString, []) Then
        Begin
          fMensagem('','Unidade Não configurada!', ['OK']);
          Result := False;
          Break;
          Exit;
        End;

        If Not qryCadCol.Locate('COL_CODCOL', Excel.FieldByName('F7').AsString, []) Then
        Begin
          fMensagem('','Colorante não cadastrado', ['OK']);
          Result := False;
          Break;
          Exit;
        End;

        If fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString) Then
        Begin
          fMensagem('','Colorante não configurado', ['OK']);
          Result := False;
          Break;
          Exit;
        End;

        qryCadDac.Insert;
        qryCadDac.FieldByName('DAC_CODSEQ').AsString := Format('%.6d', [intCodSeq]);
        qryCadDac.FieldByName('DAC_DESCRI').AsString := Excel.FieldByName('F9').AsString + ' ' + Excel.FieldByName('F5').AsString;
        qryCadDac.FieldByName('DAC_REFERE').AsString := Excel.FieldByName('F3').AsString;
        qryCadDac.FieldByName('DAC_CODUNI').AsString := fUnidadeDacar(Excel.FieldByName('F6').AsString);
        qryCadDac.FieldByName('DAC_DESUNI').AsString := fDescUnid(fUnidadeDacar(Excel.FieldByName('F6').AsString));
        qryCadDac.FieldByName('DAC_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
        qryCadDac.FieldByName('DAC_CODBAS').AsString := qryCadBas.FieldByName('BAS_BASE__').AsString;
        qryCadDac.FieldByName('DAC_CODEMP').AsString := VS_strCodEmp;
        qryCadDac.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DAC_CADDAC', VS_strCodEmp);
        qryCadDac.FieldByName('DAC_CODFML').AsString := qryCadBas.FieldByName('BAS_CODFML').AsString;
        qryCadDac.FieldByName('DAC_COLECA').AsString := Excel.FieldByName('F1').AsString;
        qryCadDac.FieldByName('DAC_CODCOR').AsString := Excel.FieldByName('F2').AsString;
        Inc(intCodSeq);
        intForm := 1;
      End;
      
      qryCadDac.FieldByName(Format('DAC_FORM%.2d', [intForm])).AsString := Excel.FieldByName('F7').AsString;
      qryCadDac.FieldByName(Format('DAC_QTDB%.2d', [intForm])).AsFloat  := fOncasParaMl(Excel.FieldByName('F8').AsString);
      Inc(intForm);
      
      pnlInfo.Caption := Format('Gerando Arquivo (%d/%d)', [Excel.RecNo, Excel.RecordCount]);
      Self.Repaint;

      If intTemp = 500 Then
      Begin
        intTemp := 0;
        pnlCabecalho.Caption := 'Geração de arquivo de cadastro - DACAR (' + TimeToStr((fNow() - fltInicio) * (Excel.RecordCount - Excel.RecNo) / 500) + ')';
        fltInicio := fNow();
        Application.ProcessMessages;
      End;

      strCodCor := Excel.FieldByName('F2').AsString;
      strCodPro := Excel.FieldByName('F4').AsString;
      strBase   := Excel.FieldByName('F5').AsString;
      strEmbala := Excel.FieldByName('F6').AsString;
      strNomCor := Excel.FieldByName('F3').AsString;
      Excel.Next;
      Inc(intTemp);
    End;
  End;

  qryCadNfm := fCriaQuery;
  qryCadNfm.SQL.Text := 'SELECT * FROM DAC_CADNFM';
  qryCadNfm.Open;
  qryCadNfm.First;

  For intCont := 1 to qryCadNfm.RecordCount Do
  Begin
    fGeraNovasFormulas(qryCadNfm);
    qryCadNfm.Next;
  End;
  Excel.Close;
  Conexao.Close;
  FreeAndNil(Excel);
  FreeAndNil(Conexao);
  FreeAndNil(Planilhas);
  FreeAndNil(qryCadDac);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadNfm);
end;

function TfrmCadDacGeraArquivo.fProcessaArquivoNovo: Boolean;
  Var
    Excel : TADODataSet;
    Conexao : TADOConnection;
    Planilhas : TStringList;

    qryCadDac : TUniQuery;
    qryCadBas : TUniQuery;
    intForm   : Integer;
    qryCadNfm : TUniQuery;
    qryCadUni : TUniQuery;
    qryCadCol : TUniquery;

    intCodSeq : Integer;
    intCont   : Integer;
    strCodCor : String;
    strPatDac : String;
    strCodPro : String;
    strBase   : String;
    strEmbala : String;

    intTemp   : Integer;
    fltInicio : Double;
    conf: IConfTinta;
begin
  Result := True;
  conf   := fGetConfTinta('DAC');
  intForm := 0;
  strPatDac := conf.fGet('TXTDAC'); //fArqIniTinta(0, 'DACAR', 'TXTDAC', '');

  If (Not FileExists(strPatDac)) Then
  Begin
    fMensagem('', 'Não encontrei o arquivo:' + #13#10 + strPatDac, ['&Ok']);
    Result := False;
    Exit;
  End;

  Conexao := TADOConnection.Create(nil);
  Conexao.LoginPrompt := False;
  Conexao.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
                              strPatDac +
                              ';Extended Properties="Excel 8.0;HDR=No;IMEX=1"';

  Conexao.Open;
  Excel := TADODataSet.Create(nil);
  Excel.Connection := Conexao;

  Planilhas := TStringList.Create;
  Conexao.GetTableNames(Planilhas);
  pLimparTabela('DAC_CADDAC');

  qryCadDac := fCriaQuery;
  qryCadDac.SQL.Text := 'SELECT * FROM DAC_CADDAC';
  qryCadDac.Open;

  qryCadBas := fCriaQuery;
  qryCadBas.SQL.Text := 'SELECT DISTINCT * FROM DAC_CADBAS';
  qryCadBas.Open;

  qryCadUni := fCriaQuery;
  qryCadUni.SQL.Text := 'SELECT DAC_UNIDAC, DAC_UNIAUT FROM DAC_UNIDAC';
  qryCadUni.Open;

  If qryCadUni.IsEmpty Then
  Begin
    fMensagem('', 'A Relação das unidades não está configurada', ['OK']);
    Result := False;
    Exit;
  End;

  qryCadCol := fCriaQuery;
  qryCadCol.SQL.Text := 'SELECT COL_CODCOL, COL_CODITE FROM DAC_CADCOL';
  qryCadCol.Open;

  If qryCadCol.IsEmpty Then
  Begin
    fMensagem('', 'Não existe colorantes cadastrados', ['OK']);
    Result := False;
    Exit;
  End;

  intCodSeq := 1;

  strCodCor := '';

  intTemp := 1;
  fltInicio := fNow();

  Excel.Close;

  //SERVCOR 3
  Excel.CommandText := ' SELECT F1 AS [COLECAO], F2 AS [COR], F3 AS [BASE], F4 AS [EMBALAGEM], '+
                       ' F5 AS [PRODUTO], F6 AS [CORANTE1], 0 AS [QTD COLORANTE], '+
                       ' F7 AS [CORANTE2], F8 AS [CORANTE3], F9 AS [CORANTE4]' +
                       ' FROM [' + Planilhas.Strings[1] + ']'+
                       ' WHERE '+
                       '   F1 IS NOT NULL AND '+
                       '   F1 <> "COLECAO" ';

  //ACRILICO MEGA
  Excel.CommandText := Excel.CommandText + ' UNION ALL' +
                       ' SELECT F1 AS [COLECAO], F2 AS [COR], F3 AS [BASE], F4 AS [EMBALAGEM], '+
                       ' "ACRILICO MEGA" AS [PRODUTO], F5 AS [CORANTE1], F6 AS [QTD COLORANTE], ' +
                       ' '''' AS [CORANTE2], '''' AS [CORANTE3], '''' AS [CORANTE4]'+
                       ' FROM [' + Planilhas.Strings[0] + ']' +
                       ' WHERE '+
                       '   F1 IS NOT NULL AND ' +
                       '   F1 <> "COLEÇÃO" ';

  Excel.Open;
  Excel.First;

  While Not Excel.Eof Do
  Begin
    If (strCodCor <> Excel.FieldByName('COR').AsString) or
       (strCodPro <> Excel.FieldByName('PRODUTO').AsString) or
       (strBase   <> Excel.FieldByName('BASE').AsString) or
       (strEmbala <> Excel.FieldByName('EMBALAGEM').AsString) Then
    Begin
      If qryCadDac.State = dsInsert Then
        qryCadDac.Post;
      If not qryCadBas.Locate('BAS_BASE__;BAS_CODFML;BAS_UNIDAD',
          VarArrayOf([Excel.FieldByName('BASE').AsString,
                      fRetornaCodFml(Excel.FieldByName('PRODUTO').AsString),
                      fRetornaEmbalagem(Excel.FieldByName('EMBALAGEM').AsString)]), []) Then
      Begin
//        fMensagem('','Base Não Cadastrada',['OK']);
//        Result := False;
//        Break;
//        Exit;
        Excel.Next;
        Continue;
      End;

      If Not qryCadUni.Locate('DAC_UNIDAC', fRetornaEMbalagem(Excel.FieldByName('EMBALAGEM').AsString), []) Then
      Begin
        fMensagem('','Unidade Não configurada!', ['OK']);
        Result := False;
        Break;
        Exit;
      End;

      qryCadDac.Insert;
      qryCadDac.FieldByName('DAC_CODSEQ').AsString := Format('%.6d', [intCodSeq]);
      qryCadDac.FieldByName('DAC_DESCRI').AsString := Excel.FieldByName('PRODUTO').AsString;
      qryCadDac.FieldByName('DAC_REFERE').AsString := Excel.FieldByName('COR').AsString;
      qryCadDac.FieldByName('DAC_CODUNI').AsString := fRetornaEmbalagem(Excel.FieldByName('EMBALAGEM').AsString);
      qryCadDac.FieldByName('DAC_DESUNI').AsString := fDescUnid(fUnidadeDacar(fRetornaEmbalagem(Excel.FieldByName('EMBALAGEM').AsString)));
      qryCadDac.FieldByName('DAC_CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
      qryCadDac.FieldByName('DAC_CODBAS').AsString := qryCadBas.FieldByName('BAS_BASE__').AsString;
      qryCadDac.FieldByName('DAC_CODEMP').AsString := VS_strCodEmp;
      qryCadDac.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DAC_CADDAC', VS_strCodEmp);
      qryCadDac.FieldByName('DAC_CODFML').AsString := qryCadBas.FieldByName('BAS_CODFML').AsString;
      qryCadDac.FieldByName('DAC_COLECA').AsString := '5003';
      qryCadDac.FieldByName('DAC_CODCOR').AsString := Excel.FieldByName('COR').AsString;
      Inc(intCodSeq);
      intForm := 1;
    End;

    If Excel.FieldByName('PRODUTO').AsString = 'ACRILICO MEGA' Then
    Begin
      If Not fEmptyStr(Excel.FieldByName('CORANTE1').AsString) Then
      Begin
        If Not qryCadCol.Locate('COL_CODCOL', fRetornaCodCol(Excel.FieldByName('CORANTE1').AsString), []) Then
        Begin
          fMensagem('','Colorante não cadastrado', ['OK']);
          Result := False;
          Break;
          Exit;
        End;
{
        If fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString) Then
        Begin
          fMensagem('','Colorante não configurado', ['OK']);
          Result := False;
          Break;
          Exit;
        End;
}
        qryCadDac.FieldByName(Format('DAC_FORM%.2d', [intForm])).AsString := Excel.FieldByName('CORANTE1').AsString;
        qryCadDac.FieldByName(Format('DAC_QTDB%.2d', [intForm])).AsFloat  := fOncasParaMl(Excel.FieldByName('QTD COLORANTE').AsString);
        Inc(intForm);
      End;
    End
    Else
    Begin
      For intCont := 1 to 4 Do
      Begin
        If Not fEmptyStr(fRetornaCodCol(Excel.FieldByName('CORANTE' + IntToStr(intCont)).AsString)) Then
        Begin
          If Not qryCadCol.Locate('COL_CODCOL', fRetornaCodCol(Excel.FieldByName('CORANTE' + IntToStr(intCont)).AsString), []) Then
          Begin
            fMensagem('','Colorante não cadastrado', ['OK']);
            Result := False;
            Break;
            Exit;
          End;
{
          If fEmptyStr(qryCadCol.FieldByName('COL_CODITE').AsString) Then
          Begin
            fMensagem('','Colorante não configurado', ['OK']);
            Result := False;
            Break;
            Exit;
          End;
}
          qryCadDac.FieldByName(Format('DAC_FORM%.2d', [intCont])).AsString := fRetornaCodCol(Excel.FieldByName('CORANTE' + IntToStr(intCont)).AsString);
          qryCadDac.FieldByName(Format('DAC_QTDB%.2d', [intCont])).AsFloat  := fOncasParaMl(fRetornaQtdCol(Excel.FieldByName('CORANTE' + IntToStr(intCont)).AsString));
        End;
      End
    End;

    pnlInfo.Caption := Format('Gerando Arquivo (%d/%d)', [Excel.RecNo, Excel.RecordCount]);
    Self.Repaint;

    If intTemp = 500 Then
    Begin
      intTemp := 0;
      pnlCabecalho.Caption := 'Geração de arquivo de cadastro - DACAR (' + TimeToStr((fNow() - fltInicio) * (Excel.RecordCount - Excel.RecNo) / 500) + ')';
      fltInicio := fNow();
      Application.ProcessMessages;
    End;

    strCodCor := Excel.FieldByName('COR').AsString;
    strCodPro := Excel.FieldByName('PRODUTO').AsString;
    strBase   := Excel.FieldByName('BASE').AsString;
    strEmbala := Excel.FieldByName('EMBALAGEM').AsString;
    Excel.Next;
    Inc(intTemp);

    Application.ProcessMessages;
  End;

  qryCadNfm := fCriaQuery;
  qryCadNfm.SQL.Text := 'SELECT * FROM DAC_CADNFM';
  qryCadNfm.Open;
  qryCadNfm.First;

  While not qryCadNfm.Eof Do
  Begin
    fGeraNovasFormulas(qryCadNfm);
    qryCadNfm.Next;
  End;

  Excel.Close;
  Conexao.Close;
  FreeAndNil(Excel);
  FreeAndNil(Conexao);
  FreeAndNil(Planilhas);
  FreeAndNil(qryCadDac);
  FreeAndNil(qryCadBas);
  FreeAndNil(qryCadNfm);
end;

function TfrmCadDacGeraArquivo.fRetornaCodCol(strColorante: String): String;
begin
  If Pos('-', strColorante) > 0 Then
    Result := Copy(strColorante, 1, Pos('-', strColorante) - 1)
  Else If strColorante = 'XXXXXXX' Then
    Result := ''
  Else
    Result := strColorante;
end;

function TfrmCadDacGeraArquivo.fRetornaCodFml(strProduto: String): String;
begin
  If strProduto = 'ACRIL ACETINADO PREMIUM' Then
    Result := '6650'
  Else If strProduto = 'ACRIL FOSCO PREMIUM' Then
    Result := '5500'
  Else If strProduto = 'ACRIL FOSCO PROFISSIONAL' Then
    Result := '7400'
  Else If strProduto = 'ACRIL FOSCO STANDARD' Then
    Result := '7750'
  Else If strProduto = 'ACRIL SEMI BRILHO PREMIUM' Then
    Result := '6600'
  Else If strProduto = 'ACRIL. SEMI BRILHO  STANDARD.' Then
    Result := '651001'
  Else If strProduto = 'ESMALTE ECOLOGICO ACETINADO' Then
    Result := '151'
  Else If strProduto = 'ESMALTE ECOLOGICO BRILHANTE' Then
    Result := '101'
  Else If strProduto = 'ESMALTE SINTETICO ACETINADO' Then
    Result := '1150'
  Else If strProduto = 'ESMALTE SINTETICO BRILHANTE' Then
    Result := '1100'
  Else If strProduto = 'GEL ENVELHECEDOR' Then
    Result := '9481'
  Else If strProduto = 'TEXTURA DESENHO' Then
    Result := '9940'
  Else If strProduto = 'TEXTURA LISA' Then
    Result := '9920'
  Else If strProduto = 'TEXTURA RUSTICA' Then
    Result := '9930'
  Else If strProduto = 'ACRILICO MEGA' Then
    Result := '755001'
  Else
    Result := '';
end;

function TfrmCadDacGeraArquivo.fRetornaEmbalagem(strEmbalagem: String): String;
begin
  If strEmbalagem = 'Quarto' Then
    Result := 'QT'
  Else If strEmbalagem = 'Galão' Then
    Result := 'GL'
  Else If strEmbalagem = 'Lata' Then
    Result := 'LA'
  Else If strEmbalagem = '19' Then
    Result := 'GL'
  Else If strEmbalagem = '49' Then
    Result := 'QT'
  Else If strEmbalagem = '59' Then
    Result := 'LA'
  Else
    Result := '';
end;

function TfrmCadDacGeraArquivo.fRetornaQtdCol(strColorante: String): String;
begin
  If Pos('-', strColorante) > 0 Then
    Result := Copy(strColorante, Pos('-', strColorante) + 1, Length(strColorante))
  Else
    Result := '0';
end;

procedure TfrmCadDacGeraArquivo.tmrProgressoTimer(Sender: TObject);
begin
  inherited;
  If strDirecao = 'D' Then
  Begin
    pnlProgInterno.Left := pnlProgInterno.Left + 5;
    If pnlProgInterno.Left + pnlProgInterno.Width >= pnlCentral.Width Then
      strDirecao := 'E';
  End
  Else
  Begin
    pnlProgInterno.Left := pnlProgInterno.Left - 5;
    If pnlProgInterno.Left <= 0 Then
      strDirecao := 'D';
  End;
end;

end.
