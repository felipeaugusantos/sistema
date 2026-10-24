unit untTDockingManager;

interface

Uses dxDockControl, System.Classes, System.SysUtils, IdCoderMIME, Data.DB,
     Vcl.Dialogs,

     Uni, DBAccess,

     untTLibCartoesFuncoes;

Type
  TDadosDockingManager = Record
    DockingManager: TdxDockingManager;
    NomeFormulario: String;
    Operador: String;
    Empresa: String;
  End;

  function SalvarLayout(ADadosDockingManager: TDadosDockingManager): Boolean;
  procedure CarregarLayout(ADadosDockingManager: TDadosDockingManager);
  function RedefinirLayout(ADadosDockingManager: TDadosDockingManager): Boolean;
  function ExportarLayout(ADadosDockingManager: TDadosDockingManager): Boolean;
  function ImportarLayout(ADadosDockingManager: TDadosDockingManager): Boolean;

implementation

function ImportarLayout(ADadosDockingManager: TDadosDockingManager): Boolean;
  Var
    LOpenDialog : TOpenDialog;
Begin
  Result := False;

  Try
    LOpenDialog := TOpenDialog.Create(Nil);
    Try
      LOpenDialog.Filter   := 'Ini Files (*.ini)|*.ini';
      If LOpenDialog.Execute Then
      Begin
        If Not TLibCartoesFuncoes.fEmptyStr(LOpenDialog.FileName) Then
        Begin
          ADadosDockingManager.DockingManager.LoadLayoutFromIniFile(LOpenDialog.FileName);
          Result := True;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LOpenDialog);
  End;
End;

function ExportarLayout(ADadosDockingManager: TDadosDockingManager): Boolean;
Var
  LSavArq : TSaveDialog;
Begin
  Result := False;
  LSavArq := TSaveDialog.Create(nil);
  Try
    LSavArq.Filter   := 'Ini Files (*.ini)|*.ini';
    LSavArq.FileName := 'Paineis_Config_'+ ADadosDockingManager.NomeFormulario + '.ini';

    If LSavArq.Execute Then
    Begin
      Try
        ADadosDockingManager.DockingManager.SaveLayoutToIniFile(LSavArq.FileName);
        Result := True;
      Except
        On e: Exception Do
        Begin
          Raise Exception.Create(E.Message);
        End;
      End;
    End

  Finally
    FreeAndNil(LSavArq);
  End;
End;

procedure CarregarLayout(ADadosDockingManager: TDadosDockingManager);
  Var
    LLayPnl: TUniQuery;
    LStream: TStream;
Begin
  Try
    LLayPnl := VS_FuncoesExternas.fICriaQuery;

    Try
      LLayPnl.Close;
      LLayPnl.SQL.Clear;
      LLayPnl.SQL.Text := 'SELECT                      '+
                          '  LAY_LAYOUT                '+
                          'FROM                        '+
                          '  LAYPNL                    '+
                          'WHERE LAY_CODEMP = :CODEMP  '+
                          '  AND LAY_CODLAY = :CODLAY  '+
                          '  AND LAY_CODOPE = :CODOPE  ';

       LLayPnl.ParamByName('CODEMP').AsString := ADadosDockingManager.Empresa;
       LLayPnl.ParamByName('CODLAY').AsString := ADadosDockingManager.NomeFormulario;
       LLayPnl.ParamByName('CODOPE').AsString := ADadosDockingManager.Operador;
       LLayPnl.Open;

      If Not LLayPnl.IsEmpty Then
      Begin
        LStream := LLayPnl.CreateBlobStream(LLayPnl.FieldByName('LAY_LAYOUT'), bmRead);
        ADadosDockingManager.DockingManager.LoadLayoutFromStream(LStream);
        FreeAndNil(LStream);
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LLayPnl);
  End;
End;

function SalvarLayout(ADadosDockingManager: TDadosDockingManager): Boolean;
  Var
    LStream: TMemoryStream;
    LLayPnl: TUniQuery;
Begin
  Result := False;

  Try
    LStream := TMemoryStream.Create;
    LLayPnl := VS_FuncoesExternas.fICriaQuery;

    Try
      ADadosDockingManager.DockingManager.SaveLayoutToStream(LStream);

      LLayPnl.Close;
      LLayPnl.SQL.Clear;
      LLayPnl.SQL.Text := 'REPLACE INTO LAYPNL (                      '+
                          '    AUTOINCREM,                            '+
                          '    LAY_CODEMP,                            '+
                          '    LAY_CODLAY,                            '+
                          '    LAY_CODOPE,                            '+
                          '    LAY_LAYOUT,                            '+
                          '    LAY_DTAALT,                            '+
                          '    LAY_HORALT                             '+
                          '  )                                        '+
                          '  VALUES                                   '+
                          '    (                                      '+
                          '      fRetAutoIncrem ("LAYPNL", :CODEMP),  '+
                          '      :CODEMP,                             '+
                          '      :CODLAY,                             '+
                          '      :CODOPE,                             '+
                          '      :LAYOUT,                             '+
                          '      CURRENT_DATE,                        '+
                          '      CURRENT_TIME                         '+
                          '    )                                      ';


       LLayPnl.ParamByName('CODEMP').AsString := ADadosDockingManager.Empresa;
       LLayPnl.ParamByName('CODLAY').AsString := ADadosDockingManager.NomeFormulario;
       LLayPnl.ParamByName('CODOPE').AsString := ADadosDockingManager.Operador;
       LLayPnl.ParamByName('LAYOUT').LoadFromStream(LStream,ftBlob);
       LLayPnl.ExecSQL;

       Result := True;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LStream);
    FreeAndNil(LLayPnl);
  End;

End;


function RedefinirLayout(ADadosDockingManager: TDadosDockingManager): Boolean;
  Var
    LLayPnl: TUniQuery;
    LStream: TStream;
Begin
  Result := False;

  Try
    LLayPnl := VS_FuncoesExternas.fICriaQuery;

    Try
      LLayPnl.Close;
      LLayPnl.SQL.Clear;
      LLayPnl.SQL.Text := 'SELECT                      '+
                          '  LAY_LAYOUT                '+
                          'FROM                        '+
                          '  LAYPNL                    '+
                          'WHERE LAY_CODLAY = :CODLAY  '+
                          '  AND LAY_CODOPE = :CODOPE  ';

       LLayPnl.ParamByName('CODLAY').AsString := ADadosDockingManager.NomeFormulario;
       LLayPnl.ParamByName('CODOPE').AsString := ADadosDockingManager.Operador;
       LLayPnl.Open;

      If LLayPnl.IsEmpty Then
      Begin
        TLibCartoesFuncoes.fMensagem('Aviso', 'Não foi encontrado o layout padrão!', ['O k']);
        Exit;
      End;

      LStream := LLayPnl.CreateBlobStream(LLayPnl.FieldByName('LAY_LAYOUT'), bmRead);
      ADadosDockingManager.DockingManager.LoadLayoutFromStream(LStream);
      FreeAndNil(LStream);

      Result := True;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LLayPnl);
  End;
End;

end.
